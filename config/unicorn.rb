worker_processes 2

working_directory "/home/zhang/gem_learn/dongfeng"

listen "/home/zhang/gem_learn/dongfeng/tmp/sockets/unicorn.dongfeng.sock"
timeout 30

pid "/home/zhang/gem_learn/dongfeng/tmp/pids/unicorn.dongfeng.pid"

stderr_path "/home/zhang/gem_learn/dongfeng/log/unicorn.log"
stdout_path "/home/zhang/gem_learn/dongfeng/log/unicorn.log"

