import os
from datetime import datetime

TEST_DIR_PATH = os.path.dirname(os.path.realpath(__file__))
TEST_SCRIPT = f"{TEST_DIR_PATH}/test.sh"
PROMPTS_PATH = f"{TEST_DIR_PATH}/prompts"
SPACES_PATH = f"{TEST_DIR_PATH}/space"
RESULTS_PATH = f"{TEST_DIR_PATH}/results"
RESULTS_FILE = f"{RESULTS_PATH}/results.txt"
LOG_PATH = f"{RESULTS_PATH}/logs"
LOG_FILE = f"{LOG_PATH}/{datetime.now().strftime('%Y-%m-%d_%H-%M-%S.log')}"

def result_path(space: str, model: str, category: str) -> str:
    return f"{RESULTS_PATH}/{category}/{model}/{space}/flake.nix"
