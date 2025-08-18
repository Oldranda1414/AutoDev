import os 
import sys
from typing import Optional
from subprocess import run, DEVNULL
from datetime import datetime

from list.categories import CATEGORIES
from list.models import MODELS
from list.spaces import SPACES
from file import move_and_rename, add_line_to_file, file_exists, remove_dir
from clean import clean
import path
from logger import Logger
from test import test

N_SIMULATION = 5
LOG_FILE = f"{path.LOG_PATH}/{datetime.now().strftime('%Y-%m-%d_%H-%M-%S.log')}"
sys.stdout = Logger(LOG_FILE)
sys.stderr = Logger(LOG_FILE)

def run_tests(category: Optional[str] = None, model: Optional[str] = None):
    _update_results(
        "---------------------------------------------",
        f"TESTS STARTED AT {_now()}",
        "\n"
    )
    try:
        if category:
            if model:
                _run_model_tests(category, model)
            else:
                _run_category_tests(category)
        else:
            _run_all_tests()
    except KeyboardInterrupt:
        clean()
        _update_results(
            f"\nTESTS INTERRUPTED BY USER AT {_now()}",
            "---------------------------------------------"
        )
        sys.exit(0)
    _update_results(
        f"TESTS FINISHED AT {_now()}",
        "---------------------------------------------"
    )

def _run_all_tests():
    for category in CATEGORIES:
        for model in MODELS:
            _run_simulation(category, model)

def _run_category_tests(category: str):
    for model in MODELS:
        _run_simulation(category, model)

def _run_model_tests(category: str, model: str):
    _run_simulation(category, model)

def _run_simulation(category: str, model: str):
    for space in SPACES:
        for simulation_index in range(1, N_SIMULATION + 1):
            if not _is_done(space, model, category, simulation_index):
                if simulation_index == 1:
                    _update_results(f"----results for category {category}, model {model} and space {space}----")
                result = test(model, category, space)
                if result.stdout:
                    sys.stdout.write("stdout:\n")
                    sys.stdout.write(result.stdout)
                if result.stderr:
                    sys.stdout.write("stderr:\n")
                    sys.stderr.write(result.stderr)
                _save_result(category, model, space, simulation_index, result.returncode == 0)

def _save_result(category: str, model: str, space: str, index: int, result: bool):
    _update_results(f"--{_now()}-- simulation {index}: {result}")
    move_and_rename(f"{path.SPACES_PATH}/{space}/flake.nix", _result_path(space, model, category, index), "file was not generated")

def _is_done(space: str, model: str, category: str, index: int) -> bool:
    return file_exists(_result_path(space, model, category, index))

def _result_path(space: str, model: str, category: str, index: int) -> str:
    return f"{path.RESULTS_PATH}/{space}/{model}/{category}/flake_{index}.nix"

def _update_results(*contents: str):
    for line in contents:
        add_line_to_file(path.RESULTS_FILE, line)

def _now() -> str:
    return datetime.today().strftime('%Y-%m-%d %H:%M:%S')

