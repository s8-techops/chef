name "local_vm"
description "This role contains all recipes for local_vm"
run_list(
          "recipe[test_file]",
          "recipe[create_vhosts]",
          "recipe[stunnel]",
          "recipe[git_210]",
          "recipe[php_ini]",
          "recipe[protobuf]",
          "recipe[ntp_master]",
          "recipe[scribe]",
          "recipe[rpms_repo]"
        )
