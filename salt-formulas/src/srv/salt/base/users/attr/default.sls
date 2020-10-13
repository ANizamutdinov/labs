{% if 'vagrantup' in grains['fqdn'] %}
sv_kernel:
  grains.present:
    - name: sv:kernel
    - value: kitchen
{% endif %}