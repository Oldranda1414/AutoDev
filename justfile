set quiet

# List available recipies
default:
  just --list --list-heading $'Available commands:\n'

# Run the main application
[no-exit-message]
run *args:
    uv --project src run src/main.py {{args}}

# Run the test script
[no-exit-message]
test *args:
    uv --project src run src/test/main.py {{args}}

# Run uv with correct project path
[no-exit-message]
uv *args:
    @uv --project src {{args}}
