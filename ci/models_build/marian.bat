@echo off
setlocal

:: Default values
set "quantization=q0f32"
set "language_pair=en-it"
set "device=vulkan"

:: Check for provided arguments
if not "%~1"=="" set "quantization=%~1"
if not "%~2"=="" set "language_pair=%~2"
if not "%~3"=="" set "device=%~3"

:: Run the Python commands
python -m mlc_llm convert_weight --model-type marian ./opus-mt-%language_pair%/ --quantization "%quantization%" --output "./output-%quantization%-opus-mt-%language_pair%"
python -m mlc_llm gen_config --model-type marian ./opus-mt-%language_pair% --quantization "%quantization%" --conv-template marian --output "./output-%quantization%-opus-mt-%language_pair%"
python -m mlc_llm compile --model-type marian "./output-%quantization%-opus-mt-%language_pair%/" --quantization "%quantization%" --device "%device%" --output "./output-%quantization%-opus-mt-%language_pair%/opus-mt-%language_pair%.so"

endlocal