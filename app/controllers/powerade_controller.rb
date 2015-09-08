class PoweradeController < ApplicationController
  
  # 글이 쓰고 보이는 페이지
  def read
    @posts = Post.all
    @mode = params[:mode]
    
  end
  
  # read에서 작성한 것들이 여기서 저장됨
  def write
    post = Post.new
    post.post_username = params[:author_name]
    post.post_password = params[:password]
    post.post_content = params[:content]
    post.save
    
    redirect_to '/'
  end
  
  
  # 수정, 삭제 할 때 패스워드를 입력받는 페이지
  def password_input
    @check_mode = params[:check_mode]
    
    if @check_mode == "false"
      @check_mode = false
    end
  end
  
  # 입력 받은 패스워드를 맞는 지 확인해서 각자의 액션으로 뿌려준다.
  def passcheck
    @mode = params[:mode]
    
    @check_mode = "true"
    
    # 글의 삭제나 수정 버튼을 눌렀을 때  
    if @mode == "delete" or @mode == "modify"
      
      one_post = Post.find(params[:id])
      
      if one_post.post_password  == params[:password]
        if @mode == "delete"
          one_post.destroy
          redirect_to "/"
        elsif @mode == "modify"
          redirect_to action:"modify", id: params[:id]
        end
      else
          @check_mode = "false"
          redirect_to action:"password_input", check_mode: @check_mode, id: params[:id], mode: @mode  
      end
      
    # 댓글의 삭제나 수정 버튼을 눌렀을 때  
    elsif @mode == "reply_delete" or @mode == "reply_modify"
    
      one_reply = Reply.find(params[:id])
      
      if one_reply.d_password == params[:password]
        if @mode == "reply_delete"
          one_reply.destroy
          redirect_to "/"
        elsif @mode == "reply_modify"
          redirect_to action:"modify_reply", id: params[:id]  
        end
      else
          @check_mode = "false"
          redirect_to action:"password_input", check_mode: @check_mode, id: params[:id], mode: @mode  
      end
    end
  end
  
  # 글의 수정을 누르고 패스워드가 일치할 때 글을 수정하는 페이지
  def modify
    @one_post = Post.find(params[:id])
  end
  
  # 글이나 댓글의 수정 완료 버튼을 누르면 처리해 주는 곳
  def update
    @mode = params[:mode]
    
    if @mode == "modify"
      one_post = Post.find(params[:id])
      one_post.post_content = params[:new_content]
      one_post.save
    
    elsif @mode == "reply"
      one_reply = Reply.find(params[:id])
      one_reply.d_reply = params[:myreply]
      one_reply.save
    end
    
    redirect_to '/'
  end
  
  # 댓글을 작성하는 페이지
  def reply
    
  end
  
  # 작성한 댓글을 저장해 주는 곳
  def write_reply
    my_reply = Reply.new
    my_reply.post_id = params[:id]
    my_reply.d_name = params[:r_name]
    my_reply.d_password = params[:r_password]
    my_reply.d_reply = params[:myreply]
    my_reply.save
    
    redirect_to action: "read", mode: params[:mode]
  
  end
  
  # 댓글을 수정하는 페이지
  def modify_reply
    @one_reply = Reply.find(params[:id])
  end
end
