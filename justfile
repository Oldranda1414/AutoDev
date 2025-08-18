set quiet

# List available recipies
default:
  just --list --list-heading $'Available commands:\n'

# Run the main application
[no-exit-message]
run *args:
    uv --project src run src/main/main.py {{args}}

# Run the test script and create a log file for it
[no-exit-message]
test *args:
    log_file="src/test/results/logs/test-$(date +'%Y-%m-%d_%H-%M-%S').log" ; \
    uv --project src run src/test/main.py {{args}} 2>&1 \
        | ts '[%Y-%m-%d %H:%M:%S]' \
        >"$log_file"

# Run uv with correct project path
[no-exit-message]
uv *args:
    @uv --project src {{args}}
