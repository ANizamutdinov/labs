#!/usr/bin/env bash
export CONSUL_HTTP_ADDR=10.0.2.15:8500
consul acl set-agent-token -token=98b4320d-def7-317a-5e54-02eb0e3bfcb0 agent a1107c02-c1cf-0b07-8d32-c70dc278d52d
