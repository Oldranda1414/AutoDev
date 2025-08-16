import os 
import sys
from typing import Optional
from subprocess import run, DEVNULL
from enum import Enum
from datetime import datetime

from categories import CATEGORIES
from models import MODELS
from test_spaces import TEST_SPACES
from file import move_and_rename, add_line_to_file

N_SIMULATION = 5
TEST_DIR_PATH = os.path.dirname(os.path.realpath(__file__))
TEST_SCRIPT = f"{TEST_DIR_PATH}/test.sh"
RESULTS_PATH = "./test_results/results.txt"

def run_tests(category: Optional[str] = None, model: Optional[str] = None):
    try:
        now = datetime.today().strftime('%Y-%m-%d %H:%M:%S')
        add_line_to_file(RESULTS_PATH, "---------------------------------------------")
        add_line_to_file(RESULTS_PATH, f"TESTS STARTED AT {now}")
        add_line_to_file(RESULTS_PATH, f"\n")
        if category:
            if model:
                _run_model_tests(category, model)
            else:
                _run_category_tests(category)
        else:
            _run_all_tests()
        now = datetime.today().strftime('%Y-%m-%d %H:%M:%S')
        add_line_to_file(RESULTS_PATH, f"TESTS FINISHED AT {now}")
        add_line_to_file(RESULTS_PATH, "---------------------------------------------")
    except KeyboardInterrupt:
        print("Process interrupted by user. Exiting gracefully.")
        now = datetime.today().strftime('%Y-%m-%d %H:%M:%S')
        add_line_to_file(RESULTS_PATH, f"\nTESTS INTERRUPTED BY USER AT {now}")
        add_line_to_file(RESULTS_PATH, "---------------------------------------------")
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
    print(f"running test for category {category} and model {model}")
    simulation_start_tag = f"----results for category {category} and model {model}----"
    _update_results(simulation_start_tag)
    for test_space in TEST_SPACES:
        accepted = 0
        for simulation_index in range(N_SIMULATION):
            command = run(
                TEST_SCRIPT + f" ./test_space/{test_space} {model} {TEST_DIR_PATH}/prompts/{category}.json",
                shell=True,
                stdout=DEVNULL,
                stderr=DEVNULL
            )
            if command.returncode == 0:
                accepted = accepted + 1
            _save_result(category, model, test_space, simulation_index, command.returncode == 0)
        simulation_summary = f"----test for category {category}, model {model} and test_space {test_space} has resulted in {accepted/N_SIMULATION} success rate.----"
        _update_results(simulation_summary)

def _save_result(category: str, model: str, test_space: str, index: int, result: bool):
    step_summary = f"simulation {index}: {result}"
    _update_results(step_summary)
    move_and_rename(f"./test_space/{test_space}/flake.nix", f"test_results/{test_space}/{model}/{category}/flake_{index}.nix", "file was not generated")

def _update_results(contents: str):
    add_line_to_file(RESULTS_PATH, contents)

