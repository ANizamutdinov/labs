#!/usr/bin/env bash
export CONSUL_HTTP_ADDR=10.0.2.15:8500
consul acl set-agent-token -token=9c952c2a-7775-527e-a21c-4af42f73ee75 agent 9c659fd3-0804-5b6b-4cbe-d216f7621118
