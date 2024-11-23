quantization="$1"
device="${2:-vulkan}"


python -m mlc_llm convert_weight --model-type whisper-tiny ./whisper-tiny/ --quantization "$quantization" --output "./output-whisper-$quantization"
python -m mlc_llm gen_config --model-type whisper-tiny ./opus-mt-$language_pair --quantization "$quantization" --conv-template marian --output "./output-whisper-$quantization"
python -m mlc_llm compile --model-type whisper-tiny "./output-whisper-$quantization/" --quantization "$quantization" --device "$device" --output "./output-whisper-$quantization.so"
