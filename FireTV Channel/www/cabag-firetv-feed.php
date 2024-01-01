<?php

$json = file_get_contents('https://v3.sermon.net/embeds/roku/directpub?a=87b2ea31-7129-4b6f-899b-7b0aee9d039d&r=fc21ed92-edc6-493e-b824-84c16262ec7a&usedby=firetv');

//EXAMPLE: http://www.lightcast.com/api/firetv/channels.php?app_id=249&app_key=gtn89uj3dsw&action=channels_videos

$data = json_decode($json, true);
//echo $json;

$newData = array();

if(isset($data['movies']) && count($data['movies']))
{
  foreach($data['movies'] as $video)
  {
    $newVideo = array();
    $newVideo['id'] = $video["id"];
    $newVideo['title'] = $video["title"];
    $newVideo['description'] = trim($video["shortDescription"]);
    if(trim($video["longDescription"]))
    {
      if(substr(trim($video["shortDescription"]), -1) == '.')
        $newVideo['description'] .= " " . $video["longDescription"];
      else
        $newVideo['description'] .= " - " . $video["longDescription"];
    }  
    
    $newVideo['duration'] = "" . $video['content']['duration'];
    $newVideo['thumbURL'] = $video['thumbnail'];
    $newVideo['imgURL'] = $video['thumbnail'];
    
    if($videoInstance = array_pop($video['content']['videos']))
      $newVideo['videoURL'] = $videoInstance['url'];
    
    $newVideo['categories'] = $video['tags'];
    
    $newVideo['channel_id'] = 1;
  
    $newData[] = $newVideo;
  }
  
  $final_json = json_encode($newData, JSON_PRETTY_PRINT);
  header('Content-Type: application/json');
  echo $final_json;
  exit;
}