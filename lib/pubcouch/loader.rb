require 'net/ftp'
require 'tempfile'

module PubCouch
  class Loader
    def initialize(atts={})
      @database = atts[:database]
      @email = atts[:email]
      @test = atts[:test]
    end
    
    def load_full
      Net::FTP.open 'ftp.ncbi.nlm.nih.gov', 'anonymous', @email do |ftp|
        ftp.chdir 'pubchem/Compound/CURRENT-Full/SDF'

        list_sdfgz(ftp).each do |file|          
          pull_chunk ftp, file
          push_chunk file
          
          break if @test
        end
      end
    end
    
    private
    
    def push_chunk file
      puts "loading #{file}"
    end
    
    def pull_chunk ftp, file
      Tempfile.open(file) do |tempfile|
        ftp.retrbinary("RETR " + file, Net::FTP::DEFAULT_BLOCKSIZE, nil) do |data|
          tempfile << data
        end
      end
    end

    def list_sdfgz ftp
      ftp.list("*.sdf.gz").inject([]) do |entries, entry|
        entry.match /(Compound_\d{8}_\d{8}\.sdf\.gz)/
        entries << $1
      end.sort
    end
  end
end