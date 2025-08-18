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

N_SIMULATION = 5

def run_tests(category: Optional[str] = None, model: Optional[str] = None):
    try:
        _update_results(
            "---------------------------------------------",
            f"TESTS STARTED AT {_now()}",
            "\n"
        )
        if category:
            if model:
                _run_model_tests(category, model)
            else:
                _run_category_tests(category)
        else:
            _run_all_tests()
        _update_results(
            f"TESTS FINISHED AT {_now()}",
            "---------------------------------------------"
        )
    except KeyboardInterrupt:
        clean()
        _update_results(
            f"\nTESTS INTERRUPTED BY USER AT {_now()}",
            "---------------------------------------------"
        )
        sys.exit(0)

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
    _update_results(f"----results for category {category} and model {model}----")
    for space in SPACES:
        for simulation_index in range(1, N_SIMULATION + 1):
            if not _is_done(space, model, category, simulation_index):
                command = run(
                    path.TEST_SCRIPT + f" {path.SPACES_PATH}/{space} {model} {path.PROMPTS_PATH}/{category}.json",
                    shell=True,
                    # stdout=DEVNULL,
                    # stderr=DEVNULL
                )
                _save_result(category, model, space, simulation_index, command.returncode == 0)

def _save_result(category: str, model: str, space: str, index: int, result: bool):
    _update_results(f"--{_now()}-- simulation {index}: {result}")
    move_and_rename(f"{path.SPACES_PATH}/{space}/flake.nix", _result_path(space, model, category, index), "file was not generated")

def _is_done(space: str, model: str, category: str, index: int):
    file_exists(_result_path(space, model, category, index))

def _result_path(space: str, model: str, category: str, index: int):
    return f"{path.RESULTS_PATH}/{space}/{model}/{category}/flake_{index}.nix"

def _update_results(*contents: str):
    for line in contents:
        add_line_to_file(path.RESULTS_FILE, line)

def _now() -> str:
        return datetime.today().strftime('%Y-%m-%d %H:%M:%S')

