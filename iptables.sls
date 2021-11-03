iptables:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: DROP
    - match: state
    - connstate: NEW
    - dport: 80
    - protocol: tcp
    - save: True
