class Post{
  var message = 'message';
  var token = 'token';
  Post(this.message,this.token);

  fromMap(data){
    message = data['message']??'deleted';
    token = data['token']??'deleted';
  }

  Map<String,Object> toMap(){
    return {
      'message': message,
      'token':token
    };
  }
}