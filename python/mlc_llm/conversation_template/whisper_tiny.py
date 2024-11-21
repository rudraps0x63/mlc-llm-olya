"""Whisper tiny  templates  - this is just a place holder, not realy used"""

from mlc_llm.protocol.conversation_protocol import Conversation, MessagePlaceholders

from .registry import ConvTemplateRegistry

# Mistral default
ConvTemplateRegistry.register_conv_template(
    Conversation(
        name="whisper-tiny",
        system_template=f"[INST] {MessagePlaceholders.SYSTEM.value}",
        system_message="not relevent for whisper",
        roles={},
        seps=[" "],
        role_content_sep=" ",
        role_empty_sep="",
        stop_str=[],
        stop_token_ids=[],
        system_prefix_token_ids=[],
        add_role_after_system_message=False,
    )
)