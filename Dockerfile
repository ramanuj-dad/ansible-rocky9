FROM ghcr.io/ansible-community/community-ee-base:2.18.5-1

USER root
RUN dnf -y install --setopt=install_weak_deps=False python3-jmespath \
    && dnf clean all
USER runner          # <- use the account that actually exists
