# frozen_string_literal: true

namespace :pull do
  task zip: [:environment] do
    REPO = 'runway7/hangar'
    BRANCH = 'frontmatter'
    zip_stream = StringIO.new(HTTParty.get("https://codeload.github.com/#{REPO}/zip/#{BRANCH}").body)
    Post.transaction do
      Post.delete_all
      Zip::InputStream.open(zip_stream) do |io|
        while (entry = io.get_next_entry)
          puts entry.name
          if entry.name.ends_with?('.md')
            post = Post.new raw: io.read
            post.save! if post.valid?
          end
        end
      end
    end
  end
end
