Voicebase API Error Codes and Messages
=======================================

============ ==================================================================================
Code         Message                                                                           
============ ==================================================================================
10000        The API you requested was not found. The available endpoints are defined in the 
 ---         VoiceBase API documentation.                                                    
10001        The request submitted to VoiceBase contains an invalid http multipart request.  
 ---         Please review the code calling the api to ensure proper use of the http         
 ---         multipart request.                                                              
10002        Your request could not be authorized because it did not contain an              
 ---         Authorization header.  Please review the VoiceBase authorization documentation  
 ---         for instructions on how to obtain and include an Authorization header in your   
 ---         request.                                                                        
10003        The Authorization header you provided is invalid and thus the request you       
 ---         submitted is not permitted. Please provide a valid VoiceBase access token.      
10004        The account associated with the request you made has been locked.  To unlock    
 ---         your account, please contact VoiceBase support.                                 
10005        The account associated with the request is pending approval by VoiceBase.  If   
 ---         you wish to expedite this process, please contact VoiceBase support.            
10006        The access token submitted with the request is not authorized to access the     
 ---         resource specified.  Please consult the VoiceBase documentation on access       
 ---         tokens and authorization.                                                       
10007        We could not parse the configuration element associated with your request.  May 
 ---         we suggest using the open source tool 'jq' (https://stedolan.github.io/jq/) to  
 ---         identify the issues with your configuration.                                    
10008        The property (%s) is not part of the %s configuration.  VoiceBase uses strict   
 ---         configuration validation and extra properties are not allowed.                  
10009        We were unable to identify the priority specified in the configuration.  Please 
 ---         provide one of low|normal|high.                                                 
10010        The configuration contains a duplicated property: '%s'.  Please remove one of   
 ---         the duplicated properties.                                                      
10011        The VoiceBase api does not support non-url-encoded query variable values.       
 ---         Please update your request to appropriate encode these values.                  
10012        You are attempting to access the profile keys api with a VoiceBase api access   
 ---         token, but this is not allowed.  Please resubmit your request with an VoiceBase 
 ---         user access token.                                                              
10013        Please submit your request with an VoiceBase user access token.                 
10107        We could not parse the metadata element associated with your request.  May we   
 ---         suggest using the open source tool 'jq' (https://stedolan.github.io/jq/) to     
 ---         identify the issues with your metadata.                                         
10108        You provided an externalId property in your metadata, but it was empty.  If you 
 ---         include the externalId property, please supply a value of length less than %s.  
10109        You provided an externalId property in your metadata, but it was too long.  If  
 ---         you include the externalId property, please supply a value of length less than  
 ---         s.                                                                              
10110        The field '%s' is included more than once in the metadata associated with the   
 ---         request.  Please include each metadata property only once.                      
10201        The media file submitted to be processed is malformed in some way and is un-    
 ---         readable by VoiceBase.                                                          
10202        The request included neither a media attachment nor a mediaUrl.  One of these   
 ---         two is required for us to process your request.                                 
10203        The media url you supplied (%s) is unreachable by VoiceBase.  This may be       
 ---         because the resource is behind a firewall.                                      
10204        The media url you supplied (%s) is malformed.  Please verify that the url is    
 ---         conformant to internet standards.                                               
10205        Requested resource not found                                                    
10206        The request submitted contains too many '%s' attachments.  The maximum is 1.    
 ---         Please review the request and ensure only one is included.                      
10207        We were not able to download a media file from the url supplied with the        
 ---         request (%s).  VoiceBase is receiving (%s) status code.                         
10301        You have requested a transcript from a media file that has not yet completed    
 ---         processing.  Transcripts only become available when a media item has status     
 ---         finished.  Please try again in a while.                                         
10401        The language specified in your configuration %s is not supported by the speech  
 ---         engine also specified in the configuration.  Please consult the VoiceBase       
 ---         language documentation for a compatibility map.                                 
10402        The '%s' language requires a locale to be specified. Please re-submit your      
 ---         request with a supported locale. Supported locales are: %s                      
10501        The property (testability) is not part of the configuration.  Please remove the 
 ---         property and try again.                                                         
10601        VoiceBase does not yet support the language specified in the configuration (    
 ---         language: %s ).  Please contact support@voicebase.com regarding languages       
 ---         support timelines.                                                              
10602        The speech model extension '%s' specified in the configuration is not supported 
 ---         in language: %s.  Please remove the speech model extension from the             
 ---         configuration.                                                                  
10603        The speech model feature '%s' specified in the configuration is not supported   
 ---         in language: %s.  Please remove the speech model feature from the configuration.
10604        Additional speech model are not yet supported                                   
10800        The request payload is larger than %s bytes. Please contact VoiceBase support   
15000        The configuration for channels is not supported. Please specify one of (        
 ---         speakerName, stereo or channels)                                                
15001        The configuration includes a channels parent property, but no channels were     
 ---         found.  Please provide list of channels.                                        
15002        The configuration includes channels, but no speaker was found.  Please provide  
 ---         speaker for the channel configuration.                                          
15003        The configuration includes channels, but only one was found.  Please provide    
 ---         both channels (Right and Left)                                                  
15004        The configuration includes %s channel(s) and the media contains %s channel(s)   
 ---         Please provide configuration for all channels in the media.                     
15005        The configuration ignores all the available channels.  Please specify one of    
 ---         the channels to process.                                                        
20001        VoiceBase could not find the speech model specified in the configuration.       
 ---         Please provide a correct model identifier.                                      
20002        The configuraton specifies a speech model '%s', but the version is incorrect.   
 ---         Please provide a valid speech model version.                                    
20003        The configuration specifies an unsupported transcription engine.  Please        
 ---         provide one from the list of supported engines.                                 
20004        The configuration enables alignment and also transcription configuration.       
 ---         Please remove the transcription configuration.                                  
20005        The configurations enables alignment and specifies the language '%s', but       
 ---         alignment not available for the selected language.  Please review the list of   
 ---         supported languages for alignment in the documentation.                         
20006        The configuration contains vocabulary configuration, but does not specify a     
 ---         named collection nor terms.  Please provide one or the other.                   
20007        Vocabulary contains a vocabulary property with both a named collection (%s) AND 
 ---         terms (%s). Only one or the other is acceptable.  You may update the            
 ---         configuration to include the named collection in one element and the terms in   
 ---         another.                                                                        
20008        The configuration specifies a vocabulary property with a named collection (%s)  
 ---         but VoiceBase could not find it.  Please consult the list of named vocabulary   
 ---         collections and correct the configuration.                                      
20009        The configuration specifies a vocabulary property with a named collection (%s)  
 ---         but it is empty.  Please either remove the empty collection or update it to     
 ---         include terms.                                                                  
20010        The configuration includes a vocabulary specification whose number of terms     
 ---         exceeds the maximum of %s.  Please reduce the vocabulary configuration.         
20101        The configuration includes a vocabulary specification whose number of scripts   
 ---         exceeds the maximum of %s.  Please reduce the vocabulary configuration.         
20012        s.  Please correct the error.                                                   
20013        The configuration includes a vocabulary specification whose number of words in  
 ---         the scripts exceeds the maximum of %s.  Please reduce the vocabulary            
 ---         configuration.                                                                  
20014        The configuration includes a vocabulary specification with an empty term.       
 ---         Please remove the empty term or include a value.                                
20015        The configuration specifies a vocabulary term (%s) with an invalid weight (%s)  
 ---         Please update the configuration to specify a vocabulary weight that is an       
 ---         integer between 0 to 5.                                                         
20016        s.  Please correct the error.                                                   
20017        The following terms (%s) are duplicated in the vocabularies configuration       
 ---         submitted with the request.  Please update the configuration to ensure terms    
 ---         are unique across the saved vocabularies and adhoc vocabularies.                
20011        The configuration specifies diarization, but it is not available for the        
 ---         selected language: %s.  Please remove this property.                            
40001        The configuration specifies a semantic configuration with either topics or      
 ---         keywords to be true.  VoiceBase requires both to be true or both to be false.   
 ---         Please update the semantic configuration to be either both true or both false.  
40002        The configuration specifies a keywords semantic configuration and the language  
 ---         s'.  VoiceBase does not support keywords semantic search for the language.      
 ---         Please remove the keywords semantic configuration for this media.               
40003        The configuration specifies a topics semantic configuration and the language '% 
 ---         s'.  VoiceBase does not support topics semantic search for the language. Please 
 ---         remove the topics semantic configuration for this media.                        
40004        The configuration specifies knowledge discovery and the language '%s'.          
 ---         VoiceBase does not support knowledge discovery for the language. Please remove  
 ---         the knowledge discovery configuration for this media.                           
40005        The configuration specifies a keyword spotting group (%s), but VoiceBase could  
 ---         not find it. Please update the configuration to specify a keyword spotting      
 ---         group in your definitions, or remove the property from the configuration for    
 ---         this media.                                                                     
40006        The configuration specifies a keyword spotting group (%s), but the definition   
 ---         contains an empty collection.  Please please add to the keyword spotting group, 
 ---         or remove the specified group from the configuration.                           
50001        The configuration specifies a prediction model (%s), but it is  not available   
 ---         for the selected language (%s).  Please please remove the model from the        
 ---         configuration.                                                                  
50002        The configuration specifies an prediction model that is missing an identifier   
 ---         or name.  Please please add an identifier or name to the model, or remove the   
 ---         property from the configuration.                                                
50003        The configuration specifies a prediction model with a classifierId (%s) that is 
 ---         not not properly formatted.  ClassifierIds must be UUIDs (https://en.wikipedia. 
 ---         org/wiki/Universally_unique_identifier).  Please correct the configuration.     
50004        The configuration includes a detector element without a detectorId or a         
 ---         detectorName.  Please update the configuration to include one or the other.     
50005        The configuration specifies a detection model with a dectorId (%s) that is not  
 ---         not properly formatted.  DetectorIds must be UUIDs (https://en.wikipedia.org/   
 ---         wiki/Universally_unique_identifier).  Please correct the configuration.         
50006        The configuration specifies a detection model (%s), but it is  not available    
 ---         for the selected language (%s).  Please please remove the model from the        
 ---         configuration.                                                                  
50007        The configuration includes a redaction element, but it does not specify audio   
 ---         or transcript.  Please update the configuration to specify one or the other (   
 ---         audio or transcript)                                                            
50008        The configuration specifies a redaction element, but it is missing the property 
 ---         s.  Please update the configuration to specify the %s.                          
50009        The configuration specifies transcript redaction and the language %s'.          
 ---         VoiceBase does not support transcript redaction in this language.  Please       
 ---         update the configuration to remove the transcript redaction element.            
50010        The configuration specifies audio redaction and the language '%s'. VoiceBase    
 ---         does not support audio redaction in this language.  Please update the           
 ---         configuration to remove the audio redaction element.                            
50011        VoiceBase does not support audio redaction for the content-type '%s'.  Please   
 ---         update the configuration to remove the audio redaction element.                 
55000        The configuration specifies content filtering and the language '%s' and region  
 ---         s'.  VoiceBase does not support content filtering in this language and region   
 ---         combination.  Please remove the content filtering element from the              
 ---         configuration.                                                                  
60001        The configuration specifies a callback element without a url.  Without a url,   
 ---         VoiceBase cannot make the callback. Please update the configuration provide     
 ---         callback url.                                                                   
60002        The configuration specifies a callback url (%s) with an invalid protocol.  The  
 ---         supported protocols are %s.  Please update the configuration to correct the     
 ---         callback url.                                                                   
60003        The configuration specifies an unknown callback include (%s).  Valid callback   
 ---         includes are %s.  Please limit the callback include configuration to items from 
 ---         the supported list.                                                             
60004        Invalid attachment type: %s                                                     
60005        Please provide callback url for type: %s                                        
60006        Invalid callback url: %s                                                        
60007        The configuration specifies a callback with an unknown callback type (%s).      
 ---         Valid callback types are %s.  Please limit the callback type configuration to   
 ---         items in the supported list.                                                    
60008        The callback configuration contains an property '%s' is not required for        
 ---         callback of type '%s'.  Please remove it from the configuration.                
60009        The callback configuration specifies a callback type (%s), but is missing the   
 ---         property '%s', which is required for callback of type '%s'.  Please specify a   
 ---         value.                                                                          
60010        The callback configuration specifies the callback type (%s) with an invalid     
 ---         form (%s).  Please specify a format from the list of formats for this type      
 ---         supported by VoiceBase (%s)                                                     
60011        The callback configuration specifies the http method '%s', which is not         
 ---         supported by VoiceBase.  Please update the configuration to specify an http     
 ---         method from one of 'POST' or 'PUT'                                              
60012        The callback configuration includes an S3 pre-signed url, but the content type  
 ---         has not been specified.  Please update the configuration to specify '%s'        
60013        The callback configuration includes an S3 pre-signed url that has the content   
 ---         type set to '%s' and it should be '%s'.  Please update the configuration        
 ---         specify the correct content type.                                               
70000        The request for an API key does not include any configuration elements.  Please 
 ---         update the key to include the configuration.                                    
70001        The request for an API key specifies both expiration (expirationDate) and time  
 ---         to live in milliseconds (ttlMillis). Please update the request to include       
 ---         expirationDate or ttlMillis, not both.                                          
70002        The request for an API key specifies an expiration (expirationDate) that is     
 ---         before now.  Please update the request to include an expirationDate value that  
 ---         is in the future, but less than 2 hours from now.                               
70003        The request for an API key specifies an expiration (expirationDate) that is     
 ---         after 2 hours now.  Please update the request to include an expirationDate      
 ---         value that is less than 2 hours from now.                                       
70004        The request for an API key specifies a time to live in milliseconds (ttlMillis) 
 ---         that is less than or equal to zero.  Please update the request to include a     
 ---         ttlMillis greater than zero.                                                    
70005        The request for an API key specifies a time to live in milliseconds (ttlMillis) 
 ---         that is greater than 2 hours.  Please update the request to include a ttlMillis 
 ---         that less than or equals to 2 hours.                                            
70006        The request for an API key specifies that the key should be ephemeral, but does 
 ---         not include an expiration date (expirationDate) nor a time to live in           
 ---         milliseconds (ttlMillis).  Please update the request to include one or the      
 ---         other.                                                                          
70007        VoiceBase could not find the API key specified in the request.  Please update   
 ---         the request to provide a known API key identifier.                              
70008        VoiceBase could not create the api key because we found the following error in  
 ---         the scope configuration: %s.  Please update the requeset to correct the issues. 
80000        The request specifies a definition (%s) in the collection (%s).  Please review  
 ---         your request to identify the definition.                                        
80100        The request is missing or has an empty keyword group (keywordGroup) element.    
 ---         Please review the request body and submit a keyword group object.               
80101        The request specifies a keyword group, but it contains no keywords.  Please     
 ---         update the request to specify keywords for the group.                           
80102        Keyword group name must be equals to '%s'                                       
80103        The keyword group submitted in the request contains an invalid keyword (%s)     
 ---         because it %s.  Please correct the error.                                       
80200        The request is missing or has an empty vocabulary element.  Please review the   
 ---         request body and submit a vocabulary object.                                    
80202        The request specifies a vocabulary name in the path (%s) that is not equal to   
 ---         the vocabulary name in the body (%s).  They must be the same.  Please update    
 ---         either the path variable or the body property.                                  
80203        The vocabulary submitted in the request contains an invalid term '%s' with the  
 ---         following errors, %s.  Please correct the errors.                               
80204        The vocabulary submitted contains both terms and scripts, but only one or the   
 ---         other is allowed.  Please correct the errors.                                   
80205        The Vocabulary submitted does not contain a vocabulary type field.  Please add  
 ---         vocabularyType: 'scripts' to the request.                                       
80206        The request specifies a vocabulary collection, but it contains neither terms    
 ---         nor scripts.  Please update the request to specify terms or scripts for the     
 ---         vocabulary.                                                                     
80207        The vocabulary submitted in the request contains an invalid script '%s' with    
 ---         the following errors, %s.  Please correct the errors.                           
80208        The vocabulary submitted in the request contains too many terms (%s).  The      
 ---         maximum is %s.  Please limit the vocabulary to the maximum.                     
80209        The vocabulary submitted contains duplicate terms (%s).  Please remove the      
 ---         duplicated terms.                                                               
80300        The request is missing or has an empty searchableFields element.  Please review 
 ---         the request body and submit a searchableFields object.                          
80301        The request specifies a searchable field name (%s) that is invalid because %s.  
 ---         Please correct the field to address the issue.                                  
80302        The request specifies a searchable field expression (%s) that is invalid        
 ---         because %s.  Please correct the expression to address the issue.                
80303        The request contains a searchable field (%s) whose length exceeds %s the        
 ---         maximum length. Please remove the field from the request.                       
90000        We encountered an issue interacting with S3 (%s)                                
90001        The data in the collection (%s) for the organization (%s) was not found.        
90002        Mongo failed to process request                                                 
90003        Internal server I/O error                                                       
90004        Message broker failed to process request                                        
90005        Data version transformation process failed                                      
============ ==================================================================================

Note: The 's%' in the messages are substitution variables that are filled when an actual error message is generated.

