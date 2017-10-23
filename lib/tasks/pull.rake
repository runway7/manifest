namespace :pull do
  task zip: [:environment] do
    Post.transaction do
      Post.delete_all
      Zip::InputStream.open(StringIO.new(HTTParty.get('https://codeload.github.com/runway7/hangar/zip/frontmatter').body)) do |io|
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

