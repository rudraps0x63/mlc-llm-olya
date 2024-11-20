quantization="${1:q0f32}"
language_pair="${2:-en-it}"


python -m mlc_llm convert_weight --model-type marian ./opus-mt-$language_pair/ --quantization "$quantization" --output "./output-$quantization-opus-mt-$language_pair"
python -m mlc_llm gen_config --model-type marian ./opus-mt-$language_pair --quantization "$quantization" --conv-template marian --output "./output-$quantization-opus-mt-$language_pair"
pythom -m mlc_llm compile --model-type marian "./output-$quantization-opus-mt-$language_pair/" --quantization "$quantization" --device vulkan --output "./output-$quantization-opus-mt-$language_pair/opus-mt-$language_pair.so"
