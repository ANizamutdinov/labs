include:
  - .attr.default

{% for user, data in pillar.get('admins', {}).items() %}
user_{{ user }}:
  user.present:
    - name: {{ user }}
    - fullname: {{ data['fullname'] }}
    - shell: {{ data['shell'] }}
    - home: {{ data['home'] }}
    - uid: {{ data['uid'] }}
    - groups: {{ data['groups'] }}
    - createhome: False
    - usergroup: True
{% endfor %}