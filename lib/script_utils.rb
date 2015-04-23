module ScriptUtils
  module_function

  def run(cmd, output: false, bundle_exec: false, ensure_success: true, working_dir: false)
    cmd = "bundle exec #{cmd}" if bundle_exec
    cmd = "cd #{working_dir}; #{cmd}" if working_dir
    output ? system(cmd) : `#{cmd}`
    raise if ensure_success && !$?.success?
  end
end