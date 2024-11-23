quantization="$1"
device="${2:-vulkan}"

python -m mlc_llm convert_weight --model-type llama ./TinyLlama-1.1B-Chat-v1.0/ --quantization "$quantization" --output "./output-TinyLlama-1.1B-Chat-v1.0-$quantization"
python -m mlc_llm gen_config --model-type llama ./TinyLlama-1.1B-Chat-v1.0 --quantization "$quantization" --conv-template tinyllama_v1_0 --output "./output-TinyLlama-1.1B-Chat-v1.0-$quantization"
python -m mlc_llm compile --model-type llama "./output-TinyLlama-1.1B-Chat-v1.0-$quantization/" --quantization "$quantization" --device "$device" --output "./TinyLlama-1.1B-Chat-v1.0-$quantization.so"

