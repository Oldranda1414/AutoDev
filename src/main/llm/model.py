from litellm import completion

from errors import ModelNameError, ModelNotInstalledError

from llm.server import get_api_base, get_server_model_name, is_model_installed 
from llm.server import start as start_server

COT_START_TAG = "<think>"
COT_END_TAG = "</think>"
REQUEST_TIMEOUT = 3600
# TODO catch timeout errors
# Feedback / Get Help: https://github.com/BerriAI/litellm/issues/new
# LiteLLM.Info: If you need to debug this error, use `litellm._turn_on_debug()'.
#
# Traceback (most recent call last):
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpx/_transports/default.py", line 101, in map_httpcore_exceptions
#     yield
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpx/_transports/default.py", line 250, in handle_request
#     resp = self._pool.handle_request(req)
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpcore/_sync/connection_pool.py", line 256, in handle_request
#     raise exc from None
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpcore/_sync/connection_pool.py", line 236, in handle_request
#     response = connection.handle_request(
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpcore/_sync/connection.py", line 103, in handle_request
#     return self._connection.handle_request(request)
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpcore/_sync/http11.py", line 136, in handle_request
#     raise exc
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpcore/_sync/http11.py", line 106, in handle_request
#     ) = self._receive_response_headers(**kwargs)
#         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpcore/_sync/http11.py", line 177, in _receive_response_headers
#     event = self._receive_event(timeout=timeout)
#             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpcore/_sync/http11.py", line 217, in _receive_event
#     data = self._network_stream.read(
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpcore/_backends/sync.py", line 126, in read
#     with map_exceptions(exc_map):
#   File "/home/randa/.local/share/uv/python/cpython-3.11.13-linux-x86_64-gnu/lib/python3.11/contextlib.py", line 158, in __exit__
#     self.gen.throw(typ, value, traceback)
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpcore/_exceptions.py", line 14, in map_exceptions
#     raise to_exc(exc) from exc
# httpcore.ReadTimeout: timed out
#
# The above exception was the direct cause of the following exception:
#
# Traceback (most recent call last):
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/llms/custom_httpx/http_handler.py", line 761, in post
#     response = self.client.send(req, stream=stream)
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpx/_client.py", line 914, in send
#     response = self._send_handling_auth(
#                ^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpx/_client.py", line 942, in _send_handling_auth
#     response = self._send_handling_redirects(
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpx/_client.py", line 979, in _send_handling_redirects
#     response = self._send_single_request(request)
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpx/_client.py", line 1014, in _send_single_request
#     response = transport.handle_request(request)
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpx/_transports/default.py", line 249, in handle_request
#     with map_httpcore_exceptions():
#   File "/home/randa/.local/share/uv/python/cpython-3.11.13-linux-x86_64-gnu/lib/python3.11/contextlib.py", line 158, in __exit__
#     self.gen.throw(typ, value, traceback)
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/httpx/_transports/default.py", line 118, in map_httpcore_exceptions
#     raise mapped_exc(message) from exc
# httpx.ReadTimeout: timed out
#
# During handling of the above exception, another exception occurred:
#
# Traceback (most recent call last):
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/llms/custom_httpx/llm_http_handler.py", line 171, in _make_common_sync_call
#     response = sync_httpx_client.post(
#                ^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/llms/custom_httpx/http_handler.py", line 765, in post
#     raise litellm.Timeout(
# litellm.exceptions.Timeout: litellm.Timeout: Connection timed out after 10000.0 seconds.
#
# During handling of the above exception, another exception occurred:
#
# Traceback (most recent call last):
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/main.py", line 3086, in completion
#     response = base_llm_http_handler.completion(
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/llms/custom_httpx/llm_http_handler.py", line 467, in completion
#     response = self._make_common_sync_call(
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/llms/custom_httpx/llm_http_handler.py", line 198, in _make_common_sync_call
#     raise self._handle_error(e=e, provider_config=provider_config)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/llms/custom_httpx/llm_http_handler.py", line 2405, in _handle_error
#     raise provider_config.get_error_class(
# litellm.llms.ollama.common_utils.OllamaError: litellm.Timeout: Connection timed out after 10000.0 seconds.
#
# During handling of the above exception, another exception occurred:
#
# Traceback (most recent call last):
#   File "/home/randa/AutoDev/src/test/../../src/main/main.py", line 9, in <module>
#     main()
#   File "/home/randa/AutoDev/src/test/../../src/main/main.py", line 6, in main
#     interface.main(sys.argv[1:])
#   File "/home/randa/AutoDev/src/main/interface.py", line 39, in main
#     dispatch(parsed_args)
#   File "/home/randa/AutoDev/src/main/dispatcher.py", line 31, in dispatch
#     generate_config(project_path, model_name, prompt_path)
#   File "/home/randa/AutoDev/src/main/handlers.py", line 12, in generate_config
#     add_config(model, project_path, prompt_path)
#   File "/home/randa/AutoDev/src/main/services/configuration.py", line 16, in add_config
#     contents = generate_config(model, project_path, prompt_path)
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/main/services/generator.py", line 6, in generate_config
#     response = model.ask(prompt)
#                ^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/main/llm/model.py", line 28, in ask
#     response = completion(
#                ^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/utils.py", line 1307, in wrapper
#     raise e
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/utils.py", line 1182, in wrapper
#     result = original_function(*args, **kwargs)
#              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/main.py", line 3430, in completion
#     raise exception_type(
#           ^^^^^^^^^^^^^^^
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/litellm_core_utils/exception_mapping_utils.py", line 2301, in exception_type
#     raise e
#   File "/home/randa/AutoDev/src/.venv/lib/python3.11/site-packages/litellm/litellm_core_utils/exception_mapping_utils.py", line 2270, in exception_type
#     raise APIConnectionError(
# litellm.exceptions.APIConnectionError: litellm.APIConnectionError: OllamaException - litellm.Timeout: Connection timed out after 10000.0 seconds.

class Model:
    
    def __init__(self, model_name: str):
        if not _is_valid_name(model_name):
            raise ModelNameError(f"Model {model_name} is not one of the accepted model names")
        if not is_model_installed(model_name):
            raise ModelNotInstalledError(f"{model_name} is not installed")

        self.model_name = model_name
        self.chat_history: list[dict[str, str]] = [
            {"role": "system", "content": "You are a helpful assistant."}
        ]

    def ask(self, message: str) -> str:
        start_server()
        self.chat_history.append({ "content": message,"role": "user"})
        response = completion(
                    model = get_server_model_name(self.model_name),
                    messages = self.chat_history,
                    api_base = get_api_base(),
                    request_timeout = REQUEST_TIMEOUT
        )
        self.chat_history.append({ "content": response,"role": "assistant"})
        cleaned_response = _clean_response(response.choices[0].message.content)
        return cleaned_response

def _is_valid_name(model_name):
    return model_name in model_names

def _clean_response(response: str):
    r = _remove_quotes(response)
    r = _remove_cot(r)
    return r

def _remove_quotes(response: str):
    return response.replace("```", "")

def _remove_cot(response: str):
    """
    Remove Chain-of-Thought from the model response

    Parameters:
    response (str): The model response

    Returns:
    str: The cleaned model response
    """
    start_cot_index = response.find(COT_START_TAG)
    end_cot_index = response.find(COT_END_TAG) + len(COT_END_TAG)
    if start_cot_index == -1 or end_cot_index == -1:
        return response
    return response[:start_cot_index] + response[end_cot_index:]

model_names = [
            "llama3",
            "qwen3",
            "smollm2",
            "phi4-mini",
            "deepseek-r1",
            "mistral"
        ]
