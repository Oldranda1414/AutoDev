import os 
from typing import Optional
from subprocess import run, DEVNULL
from enum import Enum

from categories import CATEGORIES
from models import MODELS
from test_spaces import TEST_SPACES

N_SIMULATION = 10
TEST_DIR_PATH = os.path.dirname(os.path.realpath(__file__))
TEST_SCRIPT = f"{TEST_DIR_PATH}/test.sh"

class Result(Enum):
    SUCCESS = 1
    FAIL = 2

def run_tests(category: Optional[str] = None, model: Optional[str] = None):
    if category:
        if model:
            _run_model_tests(category, model)
        else:
            _run_category_tests(category)
    else:
        _run_all_tests()

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
    for test_space in TEST_SPACES:
        command = run(
            TEST_SCRIPT + f" ./test_space/{test_space} {model} {TEST_DIR_PATH}/{category}/prompt.json",
            shell=True,
            # stdout=DEVNULL,
            # stderr=DEVNULL
        )
        test_result = Result.SUCCESS if command.returncode == 0 else Result.FAIL
        _save_result(category, model, test_space, test_result)

def _save_result(category: str, model: str, test_space: str, result: Result):
    result_str = "success" if result == Result.SUCCESS else "failure"
    print(f"test for category {category}, model {model} and test_space {test_space} has resulted in {result_str}")
