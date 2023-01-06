let
  o =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKhHCOONaaMaIeXKwq5C5k75xh2GUSOmTQFiB1c3mpwx o@swantrumpet";

  swantrumpet =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2XG+U5AZqjVeckM7w5pOk6wluRr9JX7mHP/zDcH3z1";
in { "secret1.age".publicKeys = [ o swantrumpet ]; }
