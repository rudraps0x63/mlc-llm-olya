quantization="$1"
device="${2:-vulkan}"


python -m mlc_llm convert_weight --model-type whisper-tiny ./whisper-tiny/ --quantization "$quantization" --output "./output-whisper-$quantization"
python -m mlc_llm gen_config ./whisper-tiny --model-type whisper-tiny --quantization "$quantization" --conv-template whisper-tiny --output "./output-whisper-$quantization"
python -m mlc_llm compile --model-type whisper-tiny "./output-whisper-$quantization/" --quantization "$quantization" --device "$device" --output "./output-whisper-$quantization.so"
