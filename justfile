set positional-arguments

# List available recipies
default:
  just --list --list-heading $'Available commands:\n'

# Run the main application
run:
    uv --project src run src/main.py $@

# Run the test script
test:
    uv --project src run src/test/main.py $@

# Run uv with correct project path
uv:
    uv --project src $@
