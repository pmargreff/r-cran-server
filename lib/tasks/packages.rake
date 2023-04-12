namespace :packages do
  desc "Sincronyze package for given r-cran servers"

  task sync: :environment do
    servers = ["https://cran.r-project.org/src/contrib/"]

    servers.each do |server|
      PackagesIndexer.new.call(server)
    end
  end
end
