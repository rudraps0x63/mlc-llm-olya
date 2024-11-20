quantization="$1"
language_pair="${2:-en-it}"
device="${3:vulkan}"


python -m mlc_llm convert_weight --model-type marian ./opus-mt-$language_pair/ --quantization "$quantization" --output "./output-$quantization-opus-mt-$language_pair"
python -m mlc_llm gen_config --model-type marian ./opus-mt-$language_pair --quantization "$quantization" --conv-template marian --output "./output-$quantization-opus-mt-$language_pair"
python -m mlc_llm compile --model-type marian "./output-$quantization-opus-mt-$language_pair/" --quantization "$quantization" --device "$device" --output "./output-$quantization-opus-mt-$language_pair/opus-mt-$language_pair.so"
