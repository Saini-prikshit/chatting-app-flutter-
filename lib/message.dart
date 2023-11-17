class Message{
 late final String Toid;
 late final String Fromid;
 late final String msg;
 late final String read;
 late final String type;
 late final String sent;

 Message({
   required this.Toid,
   required this.Fromid,
   required this.msg,
   required this.read,
   required this.type,
   required this.sent,
});

 Message.fromJson(Map<String,dynamic> json){
   Toid = json['Toid'];
   Fromid = json['Fromid'];
   msg = json['msg'];
   read = json['read'];
   type = json['type'];
   sent = json['sent'];
 }

 Map<String,dynamic> toJson(){
   final data = <String,dynamic>{};
   data['Toid'] = Toid;
   data['Fromid'] = Fromid;
   data['msg'] = msg;
   data['read'] = read;
   data['type'] = type;
   data['sent'] = sent;
   return data;
 }
}