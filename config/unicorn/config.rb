root_path = '/home/www/qoqocms'

worker_processes 1
timeout 180

# Location of stderr/stdout logs
stderr_path "#{root_path}/current/log/unicorn.err.log"
#stdout_path "#{root_path}/current/log/unicorn.out.log"

listen "#{root_path}/shared/unicorn.socket"
pid_file = "#{root_path}/shared/unicorn.pid"
pid pid_file

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
GC.copy_on_write_friendly = true

after_fork do |server, worker|
  begin
    old_pid = "#{server.config[:pid]}.oldbin"
    if File.exists?(old_pid) && server.pid != old_pid
      begin
# after this all request will be processed by new workers
        Process.kill("WINCH", File.read(old_pid).to_i)
        sleep 0.1
# send stop for the old master
        Process.kill("QUIT", File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end
  rescue => e
    puts "[#{Process}]: #{e.message}\n"
    puts "[#{Process}]: #{e.backtrace.join("\n")}"
  end
end
