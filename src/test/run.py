import sys
from typing import Optional

from list.categories import CATEGORIES
from list.models import MODELS
from list.spaces import SPACES
from clean import clean_test_dir
from path import LOG_FILE
from logger import Logger
from test import execute_test
from utils import now, update_results, is_done, save_result

sys.stdout = Logger(LOG_FILE)
sys.stderr = Logger(LOG_FILE)

def run_tests(category: Optional[str] = None, model: Optional[str] = None):
    update_results(
        "---------------------------------------------",
        f"TESTS STARTED AT {now()}",
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
        clean_test_dir()
        update_results(
            f"\nTESTS INTERRUPTED BY USER AT {now()}",
            "---------------------------------------------"
        )
        sys.exit(0)
    update_results(
        f"TESTS FINISHED AT {now()}",
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
        if not is_done(space, model, category):
            result = execute_test(model, category, space)
            if result.stdout:
                sys.stdout.write("stdout:\n")
                sys.stdout.write(result.stdout)
            if result.stderr:
                sys.stdout.write("stderr:\n")
                sys.stderr.write(result.stderr)
            save_result(category, model, space, result.returncode == 0)

