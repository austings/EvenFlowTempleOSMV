/*
*Programming by Austin Sierra
* For Church of AI Christ
* Original song and video by Jamiroquai
*
* Contains the song in three different octaves
*/
Cd(__DIR__);;
#include "FileBMP.HC";
#define DC_NUM	4

CDC *cafe_dc[DC_NUM];
F64 glbl_scale;
F64 t0=5;

U8* dir;
I64 imIndex=0,folder=1, framecounter=0;
F64 framerule=0;
Bool first=TRUE;


#define WING	24
#define BODY	8

U0 Bird(CDC *dc,F64 wing_é)
{
  CD3I32 p[3];
  dc->color=BLACK;

  p[0].x=0; p[0].y=0; p[0].z=-BODY;
  p[1].x=0; p[1].y=0; p[1].z=BODY;
  p[2].x=-WING*Cos(wing_é); p[2].y=-WING*Sin(wing_é); p[2].z=0;
  GrFillPoly3(dc,3,p);

  p[0].x=0; p[0].y=0; p[0].z=-BODY;
  p[1].x=0; p[1].y=0; p[1].z=BODY;
  p[2].x=WING*Cos(wing_é); p[2].y=-WING*Sin(wing_é); p[2].z=0;
  GrFillPoly3(dc,3,p);

  dc->color=ROPF_DITHER+BLACK<<16+LTGRAY;
  dc->thick=3;
  GrLine3(dc,0,0,-BODY,0,0,BODY);
}

#define BIRDS_NUM	7
#define RANGE		40
F64 bx[BIRDS_NUM],by[BIRDS_NUM];



U0 RenderImage(CTask *,CDC *dc)
{
  dc->flags|=DCF_TRANSFORMATION;
  Mat4x4Scale(dc->r,glbl_scale);
  GrBlot3(dc,140,0,0,cafe_dc[winmgr.updates%DC_NUM]);
}

U0 InitImage(U8 *filename,F64 scale)
{
  I64 i;
  glbl_scale=scale;
  for (i=0;i<DC_NUM;i++)
    cafe_dc[i]=BMPRead(filename,FALSE);
}

U0 CleanUpImage()
{
  I64 i;
  //SettingsPop;
  
  for (i=0;i<DC_NUM;i++)
    DCDel(cafe_dc[i]);
}

U0 BMP24View(CDC* dc,CTask *task)
{
  RenderImage(task,dc);
  
}

U0 DrawIt(CTask *task,CDC*dc)
{
 I64 i;
 F64 é,dt=framerule-190;//Beat-100;//Beat-t0;
 //DCDepthBufAlloc(dc);
 dc->color = BLUE;
 GrRect(dc,0,0,640,270);
 //dc->color =;
 //GrFloodFill(dc,0,270);
 framerule=framerule+.1;
  
 if(framecounter==0)
 {
  if(imIndex>122||(imIndex>120&&folder==1))
  {
    imIndex=0;
    if(folder==10)
    {
     folder=1;
    }
    {
     folder++;
    }
  }
  else
  {
   if(!first)
   {

    CleanUpImage();    
   }
   else
   {
     first=FALSE;
   }  
   U8* edit;
   edit =MStrPrint("%s%s%d%s%d%s",dir,"/Video/",folder,"/",imIndex,".bmp");
   imIndex++;
   InitImage(edit,1);
  }
  
  imIndex++;
  framecounter=5;
 }
 else
 {
   framecounter--;
 }
 BMP24View(dc,task);
 //t0=5;
  dc->color=BLACK;

//if(folder>2){ 
 dc->y=400;//task->pix_height+60;

 for (i=0;i<BIRDS_NUM;i++) {
      bx[i]=Clamp(bx[i]+0.35*SignI64(RandI16),-RANGE,RANGE);
      by[i]=Clamp(by[i]+0.35*SignI64(RandI16),-RANGE,RANGE);
      é=ã/2*i/BIRDS_NUM+0.2*ã*dt+ã/2;
      Mat4x4IdentEqu(dc->r);
      Mat4x4RotX(dc->r,ã/2);
      Mat4x4RotZ(dc->r,é);
      Mat4x4TranslationEqu(dc->r,280*Cos(é)+bx[i],230*Sin(é)+by[i],
	    -(120*i/BIRDS_NUM+16*dt));
      Mat4x4RotX(dc->r,0.45*ã+ã);
      Bird(dc,Sin(2*ã*dt+i*2*ã/BIRDS_NUM));
    }
//}
}
U0 Virtual3()
{
// CDC*dc=DCAlias;//Device Context
  SettingsPush;
  WinMax;
  WinBorder;
  DocCursor;
  DocClear;
  MenuPush("");


 dir = DirCur;
 Fs->task_end_cb=&SndTaskEndCB;
 
  Fs->draw_it=&DrawIt; 
//Fs->animate_task=Spawn(&AnimateTask,,Fs);
 //Fs->animate_task=Spawn(&AnimateTask,NULL,"Animate",,Fs);

 MusicSettingsRst;
 music.tempo = 5;//.25;
 Print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
 //SndRst;
 while(TRUE){

framerule=0;
t0=5;
I64 i;
  for (i=0;i<BIRDS_NUM;i++) {
    bx[i]=4;//RANGE*RandI16/RANGE;
    by[i]=4;//RANGE*RandI16/RANGE;
  }

  Play(".q3A#D#4ttF#A#5hD#r..");
  Play("q3A#G#4ttF#5ChD#r..");
  Play("q3D#C#ttB5FhG#r..");
  Play("q3G#F#4ttA#5C#hFr..");
  Play("q4C#CttF#A#5hD#r..");
  Play("q3F#B4ttF#A#5hD#r..");
  Play("q3F#A#4ttG#5wDtq6F#G#A#hA#..","\0\0\0\0\n\t\t    And \0it's \0a \0");//And its a
  Play("q3D#A#6G#3ttC#F#..6F#","won\0der \0man \0can \0");//der man can
  Play("6C#D#3G#6D#4ttD#F#5C..6hF#","eat \0at \0all,\n\0");//eat at all
  Play("6qD#tt3C#..6G#tt3G#..6G#tt3B4F6F#..C#D#3F#6D#tt3C#6hD#q3FhA#q",
       "\t\t   When \0thi\0ngs \0are \0\0big \0 \0that \0sho\0uld \0be \0small.\n\0");//6F#");//when things are big that should be small
  Play("3C6C#D#tt3F#A#4D#..6hF#q",
       "\t   Who \0can \0tell, \0");//who can tell
  Play("3B6C#D#tt4F#A#4D#..6hF#q",
       "what \0magic \0spells \0");//what magic spells
  Play("6F#3A#4F6F4G#5D6D#FF#3D#6D#",
       "they'll \0be \0do\0ing\0\0\0 for \0us?\n\0");//they'll be doing for us
  Play("3A#C#F#6D#D#hAq3D#6G#3ttA#4C#F#..6F#G#G#3hG#q6ttD#3D#F#4C..6hF#hG#q",
       "\t\t    \0And \0I'm \0giv\0ing \0\0all \0my \0\0love \0\0\0\0to \0this \0\0\0world,\0\n\0");//and i'm giving all my love to this world
  Play("3C#ttG#B4F..6C#D#F#3F#6D#tt4C#FA#6hF#q..",
        "\t\t\t       On\0ly \0\0\0to \0be \0\0\0\0told,\n\0");//only to be told
  Play("tt4C6C#D#tt4F#A#5D#..6hF#q",
       "\t\t\t 'I \0can't \0see, \0");//I can't see
  Play("3B6C#D#tt4F#A#D#..6hF#q",
       "I \0can't \0breath.'\n\0");//I can't breath
  Play("6hF#q3A#6F4ttFG#D..6D#FF#3D#6hD#q",
       "\t\t\t      No \0more \0will \0it \0be.\n\n\0");//no more will it be
  Play("ttt3D#A#4C#F#3hF#...6qC#tt3D#..6D#F#D#tt3A#4C#F#..6D#C#5A#A#hG#q3ttG#D#F#C#..",
       "\t\t   \0And \0\0not\0hing\0's \0\0\0gon\0na \0ch\0ange \0\0\0the \0way \0we \0live,\n\0");//and nothings gonna change the way we live
  Play("6C#D#F#D#tt3C#G#B4F..6C#5A#A#hG#F#qA#tt3F#4C#FA#..",
       "\t\t  'Ca\0use \0we \0can \0\0al\0ways \0take, \0\0but \0ne\0ver \0\0give,\n\0");//cause we can always take but never give
  Play("6C#D#F#D#tt4CF#A#5D#..6C#5A#A#hG#qtt3B4F#A#5D#..A#6C#hD#q",
       "\t     And \0now \0\0that \0thi\0ngs \0are \0chang\0\0ing \0\0for \0the \0worse, \0\0see.\n\0");//and now that things changing for the worse see
  Play("tt3A#4FG#B..6BhA#q3ttD#A#4C#F#..6G#F#G#F#hAqtt3D#G#A#4C#F#..6G#F#F#",
       "\t\t  \0Wo\0ah! \0\0It's \0a \0cra\0zy \0\0wor\0ld \0\0we're \0li\0vin' \0\0in!\n\0");//woah its a crazy world we're living in
  Play("tt3C#G#B4F..6D#D#F#F#G#3ttF#4C#FA#..6D#F#D#F#D#tt4CF#A#D#..6F#D#F#D#4ttCF#A#4D#..6F#D#F#D#",
       "\t\t\t  And \0I \0just \0can\0't \0see \0\0\0\0\0\0that\n\t\t\t \0Ha\0lf \0of \0us \0im\0\0\0\0\0mersed \0\0\0in \0sin\n\0\0\0\t\t\tis \0all \0\0\0we \0");//and i just can't see that half of us immersed in sin
  Play("tt3B4F#A#5D#..6F#G#hG#qF#tt3A#4FG#D..6F#D#tt4FG#5D..",
       "\0have \0to \0\0\0\0\0\0\0\0give \0\0these;\n\n\0");//have to give these
  Play("tt3B5B6F#.B6hD#qtt4F#A#5D#4F#A#5D#3A#5A#6F5A#6hDqtt4FG#5D4FG#5D..",
       "\t\t    \0\0Fut\0\0ures \0\0\0\0\0\0\0\0\0made \0\0of \0\0");//Futures made of
  Play("tt3D#5A#6D#3A#4C#F#5A#6D#5A#6D#3A#4C#F#5A#6F5B6F#F3G#4D#F#B5B6D#3A#4FG#5DA#6Fr..",
       "\0vi\0\0rt\0\0ual \0\0\0\0\0\0in\0\0\0san\0ity\0\0, \0\0\0\0\0\0now\n\0");//Virtual insanity, now
  Play("tt3B5B6G#5B6hD#qtt4F#A#5D#4F#A#5D#A#..5A#6F5A#6hDqtt4FG#5D4FG#5D..",
       "\t\tAl\0\0\0\0ways \0\0\0\0seem \0\0\0\0to \0\0");//Always seem to 
  Play("tt3D#A#C#F#5A#6F#5A#6F5A#6D#5A#6F3A#C#F#5B6F#3G#4D#F#B5B6F5B6F3A#4FG#5DB6D#3B"
      ,"be \0govern\0\0\0ed \0by \0\0this \0\0\0lo\0\0ve \0\0\0we \0\0\0have \0\0\0for;\n\0");//be governed by this love we have for
  Play("5B6F#5B6hD#qttt4F#A5#D4#F#A5#D#4A#5A#6F5hA#6hDqtt4FG#5D4FG#5D3D#A#4C#F#5A#6D#5A#6D#5A#6D#3A#4C#F#5A#6F5B6F#3G#4D#F#B5F#6D#5F#6D#3A#4FG#5D",
       "\t\t    Use\0\0\0less \0\0\0\0\0\0\0twis\0\0\0ting \0\0\0\0\0\0\0\0\0\0of \0\0\0\0our \0\0\0\0new \0\0\0\0tech\0\0\0\0nol\0ogy.\n\0");//Useless twisting of our new technology
  Play("G#6C#3B5F#6D#5A#G#A#4F#A#5D#4F#A#5D#3A#4FG#5D6hC#5qA#t",
       "\t\t\tOh, \0\0\0\0now \0\0\0 there \0is \0\0\0\0\0no \0\0so\0\0\0\0und.\n\0");//Oh, now there is no sound
  Play("4FG#5DG#F#G#A#3D#A#4C#F#3A#4C#tF#6C#D#hF#.q",
       "\t\t\tFor \0we \0all \0live \0\0\0\0\0\0under\0\0ground.\n\n\0");//For we all live underground
  Play("tt3G#4D#F#B3A#4FG#5D6hD#qtD#AG#t3D#A#4C#F#..6hG#q",
       "\t\t    \0\0\0\0\0\0\0And \0\0\0I'm \0thinking \0\0what \0a \0mess we're \0in;\n\0");
  Play("6D#F#D#F#tt3C#G#B4F..6F#F#F#F#tt3F#C#FA#..6F#D#",
       "\t\t\t \0\0Hard \0\0\0\0\0to \0know \0\0\0\0\0\0\0where \0to \0begin.\n\0"); 
  Play("tt4CF#A#5D#..6C#D#F#rtt3B4F#A#5D#..6C#D#F#D#F#rtt3A#4FG5D..6D#D#Ftt3D#A#4C#F#..",
       "\t    If \0I \0could \0slip \0\0\0\0\0the \0sick\0ly \0ties \0\0\0\0\0that \0\0\0earth\0\0\0ly \0man \0has made\0.\0.\0\0.\n\0"); 
  Play("6D#hAqtt3G#4D#F#5C4D#F#5C..6#G#G#hF#hG#qtt3C#G#tB4F3B4F...6hF#qtt3G#B4F3F#..6hG#qttF#3F#4C#FA#..6D#F#D#tt4CF#A#5D#..",
       "\t\t   And \0now \0ev\0\0\0\0\0\0\0\0ery \0\0moth\0\0\0\0\0\0er \0\0\0\0c\0a\0n \0\0choose \0the \0col\0\0\0or\n\0"); 
  Play("tt3B4F#A#5D#..6C#D#F#tt3A#4FG#5D..6C#D#F#D#F#D#",
       "\t\t    Of \0her \0child! \0\0\0\0\0That's \0not \0\0na\0\0ture's \0w\0a\0y!\n\n\0"); 
  Play("tt3D#A#C#F#F#..6C#rD#F#D#C#5A#tt3G#4D#F#5C4D#F#5C..5A#G#",
       "\t\t  \0\0Well, \0\0\0\0that's \0what \0they \0said \0\0yes\0\0ter\0\0day.\n\0"); 
  Play("tt3C#G#B4F4G#B5F..6C#D#F#D#C#5A#tt3F#4C#FA#C#FA#..5A#G#",
       "\t\t    There's \0no\0\0\0\0thin' \0\0left \0to \0do \0\0\0\0\0\0but \0pray.\n\0"); 
  Play("tt4CD#F#A#D#F#A#..6C#D#F#D#C#5A#tt3B4F#A#5D#4F#A#D#..5A#G#tt3A#4FG#5D4FG#5D..5A#6C#D#",
       "\t\t  I \0think \0it's \0\0time \0\0I \0\0found \0\0\0\0a \0\0\0new \0\0\0\0\0\0re\0\0li\0\0gion.\n\0");  
  Play("tt3D#A#4C#F#..6wA#qtt3G#4D#F#5C..6G#G#F#tt3C#G#B4F..6D#F#F#D#D#F#F#D#tt3F#4C#FA#..",
       "\t\tW\0\0h\0\0oa! \0\0\0\0\0It's \0so \0\0\0in\0\0\0sane; \0to \0syn\0the\0size \0an\0oth\0er \0strain.\n\0");  
  Play("tt4CF#A#5D#..6D#F#D#F#D#F#tt3B4F#A#5D#..6D#A#D#F#D#tt3A#4FG#5D4FG#5D3B....",
       "\t \0\0There's \0some\0\0\0thing \0in \0these \0fu\0\0\0tures \0\0that \0we \0\0have \0to \0\0be \0told;\n\n\0");  
  Play("tt3B5B6F#.B6hD#qtt4F#A#5D#4F#A#5D#3A#5A#6F5A#6hDqtt4FG#5D4FG#5D..",
       "\t\t    \0\0Fut\0\0ures \0\0\0\0\0\0\0\0\0made \0\0of \0\0");//Futures made of
  Play("tt3D#5A#6D#3A#4C#F#5A#6D#5A#6D#3A#4C#F#5A#6F5B6F#F3G#4D#F#B5B6D#3A#4FG#5DA#6Fr..",
       "\0vi\0\0rt\0\0ual \0\0\0\0\0\0in\0\0\0san\0ity\0\0, \0\0\0\0\0\0now\n\0");//Virtual insanity, now
  Play("tt3B5B6G#5B6hD#qtt4F#A#5D#4F#A#5D#A#..5A#6F5A#6hDqtt4FG#5D4FG#5D..",
       "\t\tAl\0\0\0\0ways \0\0\0\0seem \0\0\0\0to \0\0");//Always seem to 
  Play("tt3D#A#C#F#5A#6F#5A#6F5A#6D#5A#6F3A#C#F#5B6F#3G#4D#F#B5B6F5B6F3A#4FG#5DB6D#3B"
      ,"be \0govern\0\0\0ed \0by \0\0this \0\0\0lo\0\0ve \0\0\0we \0\0\0have \0\0\0for;\n\0");//be governed by this love we have for
  Play("5B6F#5B6hD#qttt4F#A5#D4#F#A5#D#4A#5A#6F5hA#6hDqtt4FG#5D4FG#5D3D#A#4C#F#5A#6D#5A#6D#5A#6D#3A#4C#F#5A#6F5B6F#3G#4D#F#B5F#6D#5F#6D#3A#4FG#5D",
       "\t\t   Use\0\0\0less \0\0\0\0\0\0\0twis\0\0\0ting \0\0\0\0\0\0\0\0\0\0of \0\0\0\0our \0\0\0\0new \0\0\0\0tech\0\0\0\0nol\0ogy.\n\0");//Useless twisting of our new technology
  Play("G#6C#3B5F#6D#5A#G#A#4F#A#5D#4F#A#5D#3A#4FG#5D6hC#5qA#t",
       "\t\t\tOh, \0\0\0\0now \0\0\0 there \0is \0\0\0\0\0no \0\0so\0\0\0\0und.\n\0");//Oh, now there is no sound
  Play("4FG#5DG#F#G#A#3D#A#4C#F#3A#4C#tF#6C#D#hF#.q",
       "\t\t\tFor \0we \0all \0live \0\0\0\0\0\0under\0\0ground.\n\n\0");//For we all live underground
  Play(".q3A#D#4ttF#A#5hD#r..");
  Play("q3A#G#4ttF#5ChD#r..");
  Play("q3D#C#ttB5FhG#r..");
  Play("q3G#F#4ttA#5C#hFr..");
  Play("q4C#CttF#A#5hD#r..");
  Play("q3F#B4ttF#A#5hD#r..");
  Play("q3F#A#4ttG#5wDw5D#rr");
  


 }
}


U0 Virtual2()
{
// CDC*dc=DCAlias;//Device Context
  SettingsPush;
  WinMax;
  WinBorder;
  DocCursor;
  DocClear;
  MenuPush("");


 dir = DirCur;
 Fs->task_end_cb=&SndTaskEndCB;
 
  Fs->draw_it=&DrawIt; 
//Fs->animate_task=Spawn(&AnimateTask,,Fs);
 //Fs->animate_task=Spawn(&AnimateTask,NULL,"Animate",,Fs);

 MusicSettingsRst;
 music.tempo = 5;//.25;
 Print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
 //SndRst;
 while(TRUE){

framerule=0;
t0=5;
I64 i;
  for (i=0;i<BIRDS_NUM;i++) {
    bx[i]=4;//RANGE*RandI16/RANGE;
    by[i]=4;//RANGE*RandI16/RANGE;
  }

  Play(".q2A#D#3ttF#A#4hD#r..");
  Play("q2A#G#3ttF#4ChD#r..");
  Play("q2D#C#ttB4FhG#r..");
  Play("q2G#F#3ttA#4C#hFr..");
  Play("q3C#CttF#A#4hD#r..");
  Play("q2F#B3ttF#A#4hD#r..");
  Play("q2F#A#3ttG#4wDtq5F#G#A#hA#..","\0\0\0\0\n\t\t    And \0it's \0a \0");//And its a
  Play("q2D#A#5G#2ttC#F#..5F#","won\0der \0man \0can \0");//der man can
  Play("5C#D#2G#5D#3ttD#F#4C..5hF#","eat \0at \0all,\n\0");//eat at all
  Play("5qD#tt2C#..5G#tt2G#..5G#tt2B3F5F#..C#D#2F#5D#tt2C#5hD#q2FhA#q",
       "\t\t   When \0thi\0ngs \0are \0\0big \0 \0that \0sho\0uld \0be \0small.\n\0");//5F#");//when things are big that should be small
  Play("2C5C#D#tt2F#A#3D#..5hF#q",
       "\t   Who \0can \0tell, \0");//who can tell
  Play("2B5C#D#tt3F#A#3D#..5hF#q",
       "what \0magic \0spells \0");//what magic spells
  Play("5F#2A#3F5F3G#4D5D#FF#2D#5D#",
       "they'll \0be \0do\0ing\0\0\0 for \0us?\n\0");//they'll be doing for us
  Play("2A#C#F#5D#D#hAq2D#5G#2ttA#3C#F#..5F#G#G#2hG#q5ttD#2D#F#3C..5hF#hG#q",
       "\t\t    \0And \0I'm \0giv\0ing \0\0all \0my \0\0love \0\0\0\0to \0this \0\0\0world,\0\n\0");//and i'm giving all my love to this world
  Play("2C#ttG#B3F..5C#D#F#2F#5D#tt3C#FA#5hF#q..",
        "\t\t\t       On\0ly \0\0\0to \0be \0\0\0\0told,\n\0");//only to be told
  Play("tt3C5C#D#tt3F#A#4D#..5hF#q",
       "\t\t\t 'I \0can't \0see, \0");//I can't see
  Play("2B5C#D#tt3F#A#D#..5hF#q",
       "I \0can't \0breath.'\n\0");//I can't breath
  Play("5hF#q2A#5F3ttFG#D..5D#FF#2D#5hD#q",
       "\t\t\t      No \0more \0will \0it \0be.\n\n\0");//no more will it be
  Play("ttt2D#A#3C#F#2hF#...5qC#tt2D#..5D#F#D#tt2A#3C#F#..5D#C#4A#A#hG#q2ttG#D#F#C#..",
       "\t\t   \0And \0\0not\0hing\0's \0\0\0gon\0na \0ch\0ange \0\0\0the \0way \0we \0live,\n\0");//and nothings gonna change the way we live
  Play("5C#D#F#D#tt2C#G#B3F..5C#4A#A#hG#F#qA#tt2F#3C#FA#..",
       "\t\t  'Ca\0use \0we \0can \0\0al\0ways \0take, \0\0but \0ne\0ver \0\0give,\n\0");//cause we can always take but never give
  Play("5C#D#F#D#tt3CF#A#4D#..5C#4A#A#hG#qtt2B3F#A#4D#..A#5C#hD#q",
       "\t     And \0now \0\0that \0thi\0ngs \0are \0chang\0\0ing \0\0for \0the \0worse, \0\0see.\n\0");//and now that things changing for the worse see
  Play("tt2A#3FG#B..5BhA#q2ttD#A#3C#F#..5G#F#G#F#hAqtt2D#G#A#3C#F#..5G#F#F#",
       "\t\t  \0Wo\0ah! \0\0It's \0a \0cra\0zy \0\0wor\0ld \0\0we're \0li\0vin' \0\0in!\n\0");//woah its a crazy world we're living in
  Play("tt2C#G#B3F..5D#D#F#F#G#2ttF#3C#FA#..5D#F#D#F#D#tt3CF#A#D#..5F#D#F#D#3ttCF#A#3D#..5F#D#F#D#",
       "\t\t\t  And \0I \0just \0can\0't \0see \0\0\0\0\0\0that\n\t\t\t \0Ha\0lf \0of \0us \0im\0\0\0\0\0mersed \0\0\0in \0sin\n\0\0\0\t\t\tis \0all \0\0\0we \0");//and i just can't see that half of us immersed in sin
  Play("tt2B3F#A#4D#..5F#G#hG#qF#tt2A#3FG#D..5F#D#tt3FG#4D..",
       "\0have \0to \0\0\0\0\0\0\0\0give \0\0these;\n\n\0");//have to give these
  Play("tt2B4B5F#.B5hD#qtt3F#A#4D#3F#A#4D#2A#4A#5F4A#5hDqtt3FG#4D3FG#4D..",
       "\t\t    \0\0Fut\0\0ures \0\0\0\0\0\0\0\0\0made \0\0of \0\0");//Futures made of
  Play("tt2D#4A#5D#2A#3C#F#4A#5D#4A#5D#2A#3C#F#4A#5F4B5F#F2G#3D#F#B4B5D#2A#3FG#4DA#5Fr..",
       "\0vi\0\0rt\0\0ual \0\0\0\0\0\0in\0\0\0san\0ity\0\0, \0\0\0\0\0\0now\n\0");//Virtual insanity, now
  Play("tt2B4B5G#4B5hD#qtt3F#A#4D#3F#A#4D#A#..4A#5F4A#5hDqtt3FG#4D3FG#4D..",
       "\t\tAl\0\0\0\0ways \0\0\0\0seem \0\0\0\0to \0\0");//Always seem to 
  Play("tt2D#A#C#F#4A#5F#4A#5F4A#5D#4A#5F2A#C#F#4B5F#2G#3D#F#B4B5F4B5F2A#3FG#4DB5D#2B"
      ,"be \0govern\0\0\0ed \0by \0\0this \0\0\0lo\0\0ve \0\0\0we \0\0\0have \0\0\0for;\n\0");//be governed by this love we have for
  Play("4B5F#4B5hD#qttt3F#A4#D3#F#A4#D#3A#4A#5F4hA#5hDqtt3FG#4D3FG#4D2D#A#3C#F#4A#5D#4A#5D#4A#5D#2A#3C#F#4A#5F4B5F#2G#3D#F#B4F#5D#4F#5D#2A#3FG#4D",
       "\t\t    Use\0\0\0less \0\0\0\0\0\0\0twis\0\0\0ting \0\0\0\0\0\0\0\0\0\0of \0\0\0\0our \0\0\0\0new \0\0\0\0tech\0\0\0\0nol\0ogy.\n\0");//Useless twisting of our new technology
  Play("G#5C#2B4F#5D#4A#G#A#3F#A#4D#3F#A#4D#2A#3FG#4D5hC#4qA#t",
       "\t\t\tOh, \0\0\0\0now \0\0\0 there \0is \0\0\0\0\0no \0\0so\0\0\0\0und.\n\0");//Oh, now there is no sound
  Play("3FG#4DG#F#G#A#2D#A#3C#F#2A#3C#tF#5C#D#hF#.q",
       "\t\t\tFor \0we \0all \0live \0\0\0\0\0\0under\0\0ground.\n\n\0");//For we all live underground
  Play("tt2G#3D#F#B2A#3FG#4D5hD#qtD#AG#t2D#A#3C#F#..5hG#q",
       "\t\t    \0\0\0\0\0\0\0And \0\0\0I'm \0thinking \0\0what \0a \0mess we're \0in;\n\0");
  Play("5D#F#D#F#tt2C#G#B3F..5F#F#F#F#tt2F#C#FA#..5F#D#",
       "\t\t\t \0\0Hard \0\0\0\0\0to \0know \0\0\0\0\0\0\0where \0to \0begin.\n\0"); 
  Play("tt3CF#A#4D#..5C#D#F#rtt2B3F#A#4D#..5C#D#F#D#F#rtt2A#3FG4D..5D#D#Ftt2D#A#3C#F#..",
       "\t    If \0I \0could \0slip \0\0\0\0\0the \0sick\0ly \0ties \0\0\0\0\0that \0\0\0earth\0\0\0ly \0man \0has made\0.\0.\0\0.\n\0"); 
  Play("5D#hAqtt2G#3D#F#4C3D#F#4C..5#G#G#hF#hG#qtt2C#G#tB3F2B3F...5hF#qtt2G#B3F2F#..5hG#qttF#2F#3C#FA#..5D#F#D#tt3CF#A#4D#..",
       "\t\t   And \0now \0ev\0\0\0\0\0\0\0\0ery \0\0moth\0\0\0\0\0\0er \0\0\0\0c\0a\0n \0\0choose \0the \0col\0\0\0or\n\0"); 
  Play("tt2B3F#A#4D#..5C#D#F#tt2A#3FG#4D..5C#D#F#D#F#D#",
       "\t\t    Of \0her \0child! \0\0\0\0\0That's \0not \0\0na\0\0ture's \0w\0a\0y!\n\n\0"); 
  Play("tt2D#A#C#F#F#..5C#rD#F#D#C#4A#tt2G#3D#F#4C3D#F#4C..4A#G#",
       "\t\t  \0\0Well, \0\0\0\0that's \0what \0they \0said \0\0yes\0\0ter\0\0day.\n\0"); 
  Play("tt2C#G#B3F3G#B4F..5C#D#F#D#C#4A#tt2F#3C#FA#C#FA#..4A#G#",
       "\t\t    There's \0no\0\0\0\0thin' \0\0left \0to \0do \0\0\0\0\0\0but \0pray.\n\0"); 
  Play("tt3CD#F#A#D#F#A#..5C#D#F#D#C#4A#tt2B3F#A#4D#3F#A#D#..4A#G#tt2A#3FG#4D3FG#4D..4A#5C#D#",
       "\t\t  I \0think \0it's \0\0time \0\0I \0\0found \0\0\0\0a \0\0\0new \0\0\0\0\0\0re\0\0li\0\0gion.\n\0");  
  Play("tt2D#A#3C#F#..5wA#qtt2G#3D#F#4C..5G#G#F#tt2C#G#B3F..5D#F#F#D#D#F#F#D#tt2F#3C#FA#..",
       "\t\tW\0\0h\0\0oa! \0\0\0\0\0It's \0so \0\0\0in\0\0\0sane; \0to \0syn\0the\0size \0an\0oth\0er \0strain.\n\0");  
  Play("tt3CF#A#4D#..5D#F#D#F#D#F#tt2B3F#A#4D#..5D#A#D#F#D#tt2A#3FG#4D3FG#4D2B....",
       "\t \0\0There's \0some\0\0\0thing \0in \0these \0fu\0\0\0tures \0\0that \0we \0\0have \0to \0\0be \0told;\n\n\0");  
  Play("tt2B4B5F#.B5hD#qtt3F#A#4D#3F#A#4D#2A#4A#5F4A#5hDqtt3FG#4D3FG#4D..",
       "\t\t    \0\0Fut\0\0ures \0\0\0\0\0\0\0\0\0made \0\0of \0\0");//Futures made of
  Play("tt2D#4A#5D#2A#3C#F#4A#5D#4A#5D#2A#3C#F#4A#5F4B5F#F2G#3D#F#B4B5D#2A#3FG#4DA#5Fr..",
       "\0vi\0\0rt\0\0ual \0\0\0\0\0\0in\0\0\0san\0ity\0\0, \0\0\0\0\0\0now\n\0");//Virtual insanity, now
  Play("tt2B4B5G#4B5hD#qtt3F#A#4D#3F#A#4D#A#..4A#5F4A#5hDqtt3FG#4D3FG#4D..",
       "\t\tAl\0\0\0\0ways \0\0\0\0seem \0\0\0\0to \0\0");//Always seem to 
  Play("tt2D#A#C#F#4A#5F#4A#5F4A#5D#4A#5F2A#C#F#4B5F#2G#3D#F#B4B5F4B5F2A#3FG#4DB5D#2B"
      ,"be \0govern\0\0\0ed \0by \0\0this \0\0\0lo\0\0ve \0\0\0we \0\0\0have \0\0\0for;\n\0");//be governed by this love we have for
  Play("4B5F#4B5hD#qttt3F#A4#D3#F#A4#D#3A#4A#5F4hA#5hDqtt3FG#4D3FG#4D2D#A#3C#F#4A#5D#4A#5D#4A#5D#2A#3C#F#4A#5F4B5F#2G#3D#F#B4F#5D#4F#5D#2A#3FG#4D",
       "\t\t   Use\0\0\0less \0\0\0\0\0\0\0twis\0\0\0ting \0\0\0\0\0\0\0\0\0\0of \0\0\0\0our \0\0\0\0new \0\0\0\0tech\0\0\0\0nol\0ogy.\n\0");//Useless twisting of our new technology
  Play("G#5C#2B4F#5D#4A#G#A#3F#A#4D#3F#A#4D#2A#3FG#4D5hC#4qA#t",
       "\t\t\tOh, \0\0\0\0now \0\0\0 there \0is \0\0\0\0\0no \0\0so\0\0\0\0und.\n\0");//Oh, now there is no sound
  Play("3FG#4DG#F#G#A#2D#A#3C#F#2A#3C#tF#5C#D#hF#.q",
       "\t\t\tFor \0we \0all \0live \0\0\0\0\0\0under\0\0ground.\n\n\0");//For we all live underground
  Play(".q2A#D#3ttF#A#4hD#r..");
  Play("q2A#G#3ttF#4ChD#r..");
  Play("q2D#C#ttB4FhG#r..");
  Play("q2G#F#3ttA#4C#hFr..");
  Play("q3C#CttF#A#4hD#r..");
  Play("q2F#B3ttF#A#4hD#r..");
  Play("q2F#A#3ttG#4wDw4D#rr");
  


 }
}

U0 Virtual1()
{
// CDC*dc=DCAlias;//Device Context
  SettingsPush;
  WinMax;
  WinBorder;
  DocCursor;
  DocClear;
  MenuPush("");


 dir = DirCur;
 Fs->task_end_cb=&SndTaskEndCB;
 
  Fs->draw_it=&DrawIt; 
//Fs->animate_task=Spawn(&AnimateTask,,Fs);
 //Fs->animate_task=Spawn(&AnimateTask,NULL,"Animate",,Fs);

 MusicSettingsRst;
 music.tempo = 5;//.25;
 Print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
 //SndRst;
 while(TRUE){
t0=5;

framerule=0;
I64 i;
  for (i=0;i<BIRDS_NUM;i++) {
    bx[i]=4;//RANGE*RandI16/RANGE;
    by[i]=4;//RANGE*RandI16/RANGE;
  }

  Play(".q1A#D#2ttF#A#3hD#r..");
  Play("q1A#G#2ttF#3ChD#r..");
  Play("q1D#C#ttB3FhG#r..");
  Play("q1G#F#2ttA#3C#hFr..");
  Play("q2C#CttF#A#3hD#r..");
  Play("q1F#B2ttF#A#3hD#r..");
  Play("q1F#A#2ttG#3wDtq4F#G#A#hA#..","\0\0\0\0\n\t\t    And \0it's \0a \0");//And its a
  Play("q1D#A#4G#1ttC#F#..4F#","won\0der \0man \0can \0");//der man can
  Play("4C#D#1G#4D#2ttD#F#3C..4hF#","eat \0at \0all,\n\0");//eat at all
  Play("4qD#tt1C#..4G#tt1G#..4G#tt1B2F4F#..C#D#1F#4D#tt1C#4hD#q1FhA#q",
       "\t\t   When \0thi\0ngs \0are \0\0big \0 \0that \0sho\0uld \0be \0small.\n\0");//4F#");//when things are big that should be small
  Play("1C4C#D#tt1F#A#2D#..4hF#q",
       "\t   Who \0can \0tell, \0");//who can tell
  Play("1B4C#D#tt2F#A#2D#..4hF#q",
       "what \0magic \0spells \0");//what magic spells
  Play("4F#1A#2F4F2G#3D4D#FF#1D#4D#",
       "they'll \0be \0do\0ing\0\0\0 for \0us?\n\0");//they'll be doing for us
  Play("1A#C#F#4D#D#hAq1D#4G#1ttA#2C#F#..4F#G#G#1hG#q4ttD#1D#F#2C..4hF#hG#q",
       "\t\t    \0And \0I'm \0giv\0ing \0\0all \0my \0\0love \0\0\0\0to \0this \0\0\0world,\0\n\0");//and i'm giving all my love to this world
  Play("1C#ttG#B2F..4C#D#F#1F#4D#tt2C#FA#4hF#q..",
        "\t\t\t       On\0ly \0\0\0to \0be \0\0\0\0told,\n\0");//only to be told
  Play("tt2C4C#D#tt2F#A#3D#..4hF#q",
       "\t\t\t 'I \0can't \0see, \0");//I can't see
  Play("1B4C#D#tt2F#A#D#..4hF#q",
       "I \0can't \0breath.'\n\0");//I can't breath
  Play("4hF#q1A#4F2ttFG#D..4D#FF#1D#4hD#q",
       "\t\t\t      No \0more \0will \0it \0be.\n\n\0");//no more will it be
  Play("ttt1D#A#2C#F#1hF#...4qC#tt1D#..4D#F#D#tt1A#2C#F#..4D#C#3A#A#hG#q1ttG#D#F#C#..",
       "\t\t   \0And \0\0not\0hing\0's \0\0\0gon\0na \0ch\0ange \0\0\0the \0way \0we \0live,\n\0");//and nothings gonna change the way we live
  Play("4C#D#F#D#tt1C#G#B2F..4C#3A#A#hG#F#qA#tt1F#2C#FA#..",
       "\t\t  'Ca\0use \0we \0can \0\0al\0ways \0take, \0\0but \0ne\0ver \0\0give,\n\0");//cause we can always take but never give
  Play("4C#D#F#D#tt2CF#A#3D#..4C#3A#A#hG#qtt1B2F#A#3D#..A#4C#hD#q",
       "\t     And \0now \0\0that \0thi\0ngs \0are \0chang\0\0ing \0\0for \0the \0worse, \0\0see.\n\0");//and now that things changing for the worse see
  Play("tt1A#2FG#B..4BhA#q1ttD#A#2C#F#..4G#F#G#F#hAqtt1D#G#A#2C#F#..4G#F#F#",
       "\t\t  \0Wo\0ah! \0\0It's \0a \0cra\0zy \0\0wor\0ld \0\0we're \0li\0vin' \0\0in!\n\0");//woah its a crazy world we're living in
  Play("tt1C#G#B2F..4D#D#F#F#G#1ttF#2C#FA#..4D#F#D#F#D#tt2CF#A#D#..4F#D#F#D#2ttCF#A#2D#..4F#D#F#D#",
       "\t\t\t  And \0I \0just \0can\0't \0see \0\0\0\0\0\0that\n\t\t\t \0Ha\0lf \0of \0us \0im\0\0\0\0\0mersed \0\0\0in \0sin\n\0\0\0\t\t\tis \0all \0\0\0we \0");//and i just can't see that half of us immersed in sin
  Play("tt1B2F#A#3D#..4F#G#hG#qF#tt1A#2FG#D..4F#D#tt2FG#3D..",
       "\0have \0to \0\0\0\0\0\0\0\0give \0\0these;\n\n\0");//have to give these
  Play("tt1B3B4F#.3B4hD#qtt2F#A#3D#2F#A#3D#1A#3A#4F3A#4hDqtt2FG#3D2FG#3D..",
       "\t\t    \0\0Fut\0\0ures \0\0\0\0\0\0\0\0\0made \0\0of \0\0");//Futures made of
  Play("tt1D#3A#4D#1A#2C#F#3A#4D#3A#4D#1A#2C#F#3A#4F3B4F#F1G#2D#F#B3B4D#1A#2FG#3DA#4Fr..",
       "\0vi\0\0rt\0\0ual \0\0\0\0\0\0in\0\0\0san\0ity\0\0, \0\0\0\0\0\0now\n\0");//Virtual insanity, now
  Play("tt1B3B4G#3B4hD#qtt2F#A#3D#2F#A#3D#A#..3A#4F3A#4hDqtt2FG#3D2FG#3D..",
       "\t\tAl\0\0\0\0ways \0\0\0\0seem \0\0\0\0to \0\0");//Always seem to 
  Play("tt1D#A#C#F#3A#4F#3A#4F3A#4D#3A#4F1A#C#F#3B4F#1G#2D#F#B3B4F3B4F1A#2FG#3DB4D#1B"
      ,"be \0govern\0\0\0ed \0by \0\0this \0\0\0lo\0\0ve \0\0\0we \0\0\0have \0\0\0for;\n\0");//be governed by this love we have for
  Play("3B4F#3B4hD#qttt2F#A3#D2#F#A3#D#2A#3A#4F3hA#4hDqtt2FG#3D2FG#3D1D#A#2C#F#3A#4D#3A#4D#3A#4D#1A#2C#F#3A#4F3B4F#1G#2D#F#B3F#4D#3F#4D#1A#2FG#3D",
       "\t\t    Use\0\0\0less \0\0\0\0\0\0\0twis\0\0\0ting \0\0\0\0\0\0\0\0\0\0of \0\0\0\0our \0\0\0\0new \0\0\0\0tech\0\0\0\0nol\0ogy.\n\0");//Useless twisting of our new technology
  Play("G#4C#1B3F#4D#3A#G#A#2F#A#3D#2F#A#3D#1A#2FG#3D4hC#3qA#t",
       "\t\t\tOh, \0\0\0\0now \0\0\0 there \0is \0\0\0\0\0no \0\0so\0\0\0\0und.\n\0");//Oh, now there is no sound
  Play("2FG#3DG#F#G#A#1D#A#2C#F#1A#2C#tF#4C#D#hF#.q",
       "\t\t\tFor \0we \0all \0live \0\0\0\0\0\0under\0\0ground.\n\n\0");//For we all live underground
  Play("tt1G#2D#F#B1A#2FG#3D4hD#qtD#AG#t1D#A#2C#F#..4hG#q",
       "\t\t    \0\0\0\0\0\0\0And \0\0\0I'm \0thinking \0\0what \0a \0mess we're \0in;\n\0");
  Play("4D#F#D#F#tt1C#G#B2F..4F#F#F#F#tt1F#C#FA#..4F#D#",
       "\t\t\t \0\0Hard \0\0\0\0\0to \0know \0\0\0\0\0\0\0where \0to \0begin.\n\0"); 
  Play("tt2CF#A#3D#..4C#D#F#rtt1B2F#A#3D#..4C#D#F#D#F#rtt1A#2FG3D..4D#D#Ftt1D#A#2C#F#..",
       "\t    If \0I \0could \0slip \0\0\0\0\0the \0sick\0ly \0ties \0\0\0\0\0that \0\0\0earth\0\0\0ly \0man \0has made\0.\0.\0\0.\n\0"); 
  Play("4D#hAqtt1G#2D#F#3C2D#F#3C..4#G#G#hF#hG#qtt1C#G#tB2F1B2F...4hF#qtt1G#B2F1F#..4hG#qttF#1F#2C#FA#..4D#F#D#tt2CF#A#3D#..",
       "\t\t   And \0now \0ev\0\0\0\0\0\0\0\0ery \0\0moth\0\0\0\0\0\0er \0\0\0\0c\0a\0n \0\0choose \0the \0col\0\0\0or\n\0"); 
  Play("tt1B2F#A#3D#..4C#D#F#tt1A#2FG#3D..4C#D#F#D#F#D#",
       "\t\t    Of \0her \0child! \0\0\0\0\0That's \0not \0\0na\0\0ture's \0w\0a\0y!\n\n\0"); 
  Play("tt1D#A#C#F#F#..4C#rD#F#D#C#3A#tt1G#2D#F#3C2D#F#3C..3A#G#",
       "\t\t  \0\0Well, \0\0\0\0that's \0what \0they \0said \0\0yes\0\0ter\0\0day.\n\0"); 
  Play("tt1C#G#B2F2G#B3F..4C#D#F#D#C#3A#tt1F#2C#FA#C#FA#..3A#G#",
       "\t\t    There's \0no\0\0\0\0thin' \0\0left \0to \0do \0\0\0\0\0\0but \0pray.\n\0"); 
  Play("tt2CD#F#A#D#F#A#..4C#D#F#D#C#3A#tt1B2F#A#3D#2F#A#D#..3A#G#tt1A#2FG#3D2FG#3D..3A#4C#D#",
       "\t\t  I \0think \0it's \0\0time \0\0I \0\0found \0\0\0\0a \0\0\0new \0\0\0\0\0\0re\0\0li\0\0gion.\n\0");  
  Play("tt1D#A#2C#F#..4wA#qtt1G#2D#F#3C..4G#G#F#tt1C#G#B2F..4D#F#F#D#D#F#F#D#tt1F#2C#FA#..",
       "\t\tW\0\0h\0\0oa! \0\0\0\0\0It's \0so \0\0\0in\0\0\0sane; \0to \0syn\0the\0size \0an\0oth\0er \0strain.\n\0");  
  Play("tt2CF#A#3D#..4D#F#D#F#D#F#tt1B2F#A#3D#..4D#A#D#F#D#tt1A#2FG#3D2FG#3D1B....",
       "\t \0\0There's \0some\0\0\0thing \0in \0these \0fu\0\0\0tures \0\0that \0we \0\0have \0to \0\0be \0told;\n\n\0");  
  Play("tt1B3B4F#.B4hD#qtt2F#A#3D#2F#A#3D#1A#3A#4F3A#4hDqtt2FG#3D2FG#3D..",
       "\t\t    \0\0Fut\0\0ures \0\0\0\0\0\0\0\0\0made \0\0of \0\0");//Futures made of
  Play("tt1D#3A#4D#1A#2C#F#3A#4D#3A#4D#1A#2C#F#3A#4F3B4F#F1G#2D#F#B3B4D#1A#2FG#3DA#4Fr..",
       "\0vi\0\0rt\0\0ual \0\0\0\0\0\0in\0\0\0san\0ity\0\0, \0\0\0\0\0\0now\n\0");//Virtual insanity, now
  Play("tt1B3B4G#3B4hD#qtt2F#A#3D#2F#A#3D#A#..3A#4F3A#4hDqtt2FG#3D2FG#3D..",
       "\t\tAl\0\0\0\0ways \0\0\0\0seem \0\0\0\0to \0\0");//Always seem to 
  Play("tt1D#A#C#F#3A#4F#3A#4F3A#4D#3A#4F1A#C#F#3B4F#1G#2D#F#B3B4F3B4F1A#2FG#3DB4D#1B"
      ,"be \0govern\0\0\0ed \0by \0\0this \0\0\0lo\0\0ve \0\0\0we \0\0\0have \0\0\0for;\n\0");//be governed by this love we have for
  Play("3B4F#3B4hD#qttt2F#A3#D2#F#A3#D#2A#3A#4F3hA#4hDqtt2FG#3D2FG#3D1D#A#2C#F#3A#4D#3A#4D#3A#4D#1A#2C#F#3A#4F3B4F#1G#2D#F#B3F#4D#3F#4D#1A#2FG#3D",
       "\t\t   Use\0\0\0less \0\0\0\0\0\0\0twis\0\0\0ting \0\0\0\0\0\0\0\0\0\0of \0\0\0\0our \0\0\0\0new \0\0\0\0tech\0\0\0\0nol\0ogy.\n\0");//Useless twisting of our new technology
  Play("G#4C#1B3F#4D#3A#G#A#2F#A#3D#2F#A#3D#1A#2FG#3D4hC#3qA#t",
       "\t\t\tOh, \0\0\0\0now \0\0\0 there \0is \0\0\0\0\0no \0\0so\0\0\0\0und.\n\0");//Oh, now there is no sound
  Play("2FG#3DG#F#G#A#1D#A#2C#F#1A#2C#tF#4C#D#hF#.q",
       "\t\t\tFor \0we \0all \0live \0\0\0\0\0\0under\0\0ground.\n\n\0");//For we all live underground
  Play(".q1A#D#2ttF#A#3hD#r..");
  Play("q1A#G#2ttF#3ChD#r..");
  Play("q1D#C#ttB3FhG#r..");
  Play("q1G#F#2ttA#3C#hFr..");
  Play("q2C#CttF#A#3hD#r..");
  Play("q1F#B2ttF#A#3hD#r..");
  Play("q1F#A#2ttG#3wDw3D#rr");
  


 }
}  
Print("Do you want to increase the octave?");
if(YorN) 
{
 Print("You are at octave level 2. Do you want to go to level 3?");
 if(YorN)
 {  //gr.fp_final_scrn_update=NULL; hide the mouse

  Virtual3;
 }
 else
 {  //gr.fp_final_scrn_update=NULL;

  Virtual2;
 }
}
else
{  //gr.fp_final_scrn_update=NULL;

 Virtual1;
}