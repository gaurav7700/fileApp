require 'search_in_file'
require 'docx'
class FilesController < ApplicationController
  def new
    if params[:path].to_s.length >0
      @path = Rails.root.to_s + '/' + params[:path].to_s
      text = "#{params[:text].to_s}"

      @arrayFilesAll = Array.new # stores all files under path
      @contents = Array.new
      Dir.chdir(@path)
      @arrayFilesAll = Dir.glob("**/*.{doc,docx}",
                                base: @path)
      # searchForContent
      @arrayFilesAll.each do |file|
        hash_file = SearchInFile.search(file, text)
        if hash_file.length!=0
          content = hash_file[0][:paragraphs].join('')
          @contents.append(content)



        end
      end
    end
  end
end