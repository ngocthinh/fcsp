module Supports
  class ShowUser
    attr_reader :job_active, :job_skill, :portfolios, :user

    def initialize user, page_param
      @user = user
      @page_param = page_param
    end

    def job_active
      Job.active.includes :images, :skills, :job_skills
    end

    def job_skill
      ArrayJob.get_job job_active, @user
    end

    def portfolios
      @user.user_portfolios.includes(:images).order created_at: :DESC
    end

    def pagination resources
      resources.page(@page_param).per Settings.resources.per_page
    end

    def skills
      pagination @user.skills.order(created_at: :desc)
    end

    def socials
      pagination @user.socials
    end

    def clubs
      pagination @user.clubs
    end
  end
end
