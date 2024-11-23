quantization="$1"
device="${2:-vulkan}"

python -m mlc_llm convert_weight --model-type llama-3_1 ./Llama-3.1-8B-Instruct/ --quantization "$quantization" --output "./output-Llama-3.1-8B-Instruct-$quantization"
python -m mlc_llm gen_config --model-type llama-3_1 ./Llama-3.1-8B-Instruct --quantization "$quantization" --conv-template llama-3_1 --output "./output-Llama-3.1-8B-Instruct-$quantization"
python -m mlc_llm compile --model-type llama-3_1 "./output-Llama-3.1-8B-Instruct-$quantization/" --quantization "$quantization" --device "$device" --output "./Llama-3.1-8B-Instruct-$quantization.so"

