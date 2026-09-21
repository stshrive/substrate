#!/usr/bin/env bash

# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# The environment every hack/*-kind.sh wrapper needs, so the installer and the
# tests agree on the registry, the snapshot bucket and the cluster they target.
# Source it after cd'ing to the repository root. Build-specific settings
# (KO_DEFAULTPLATFORMS, ATE_INSTALL_KIND) stay with the wrappers that build.

# A developer's .ate-dev-env.sh describes a real GCP project and GKE cluster —
# PROJECT_ID, GCE_REGION, CLUSTER_LOCATION, KUBECTL_CONTEXT and friends. Sourcing
# it would aim a local install at that cloud project; the visible symptom is
# usually golden-snapshot uploads 404ing against a GCS bucket the in-cluster
# rustfs does not have.
export NO_DEV_ENV="true"

export KO_DOCKER_REPO="${KO_DOCKER_REPO:-localhost:5001}"
export BUCKET_NAME="${BUCKET_NAME:-ate-snapshots}"

# Pin the context rather than inheriting whatever current-context happens to be
# — or nothing at all, which kubectl reports as a localhost:8080 dial failure.
# An explicit KUBECTL_CONTEXT still wins.
KIND_CLUSTER_NAME="${KIND_CLUSTER_NAME:-kind}"
export KUBECTL_CONTEXT="${KUBECTL_CONTEXT:-kind-${KIND_CLUSTER_NAME}}"
