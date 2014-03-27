module Aedile
  module DockerUtil
    INIT_CGROUP_PATH = "/proc/1/cgroup"

    def in_container?
      return false unless File.exists?(INIT_CGROUP_PATH)

      init_cgroup = IO.read(INIT_CGROUP_PATH)
      records = init_cgroup.split("\n").map{|l| l.split(":")}

      records.any?{|id,subsystem,cgroup| cgroup != "/" }
    end

  end
end