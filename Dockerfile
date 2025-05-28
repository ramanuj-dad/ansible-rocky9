FROM ghcr.io/ansible-community/community-ee-base:2.16.7-1

USER root
# Install your missing dependencies
RUN dnf -y install --setopt=install_weak_deps=False python3-jmespath \
    && dnf clean all

# Switch back to the designated user for running Ansible tasks.
# Based on your container inspection, the default user is 1000.
USER 1000