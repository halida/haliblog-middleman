# -*- coding: utf-8 -*-
require './db'

def updateDB
  """因为文档是采用rst编写的, 需要能够自动从源里面导入进来资料"""
  # 更新
  # `cd ../blog; git pull`

  blog_dir = '../blog/'
  Dir.chdir blog_dir

  # 获取列表
  lists = Dir.glob('*.rst')
  # 不获取临时文件(_开头)
  lists.reject!{|file| File.basename(file)[0] == '_'}

  # 生成时间, 文件名列表
  infos = lists.map do |file|
    [
     # created
     %x{git log --format=%ai "#{file}"| tail -1},
     # updated
     %x{git log --format=%ai "#{file}"| head -1},
     File.basename(file, '.rst')
    ]
  end
  # 按时间排序
  infos.sort!
  # 把资料塞到数据库里面
  Article.destroy
  infos.each do |created, updated, title|
    puts title
    source = File.open(File.join(blog_dir, title+'.rst')).read
    article = Article.new(
                          :title => title,
                          :raw_content => source,
                          :created => created[0,16],
                          :updated => updated[0,16]
                          )
    article.save
  end
  
end

if __FILE__ == $0
  updateDB
end
