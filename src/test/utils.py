from typing import Optional

from categories import CATEGORIES
from models import MODELS

N_SIMULATION = 10

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
