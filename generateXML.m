function [faces] = generateXML(facesdir)
% Uses the face++ api to get an ordered list of the landmarks of the faces
% in dir, and generates the xml files needed for dlib to train its model
% with
%
% Input:
% dir - the path to the  directory with faces to train with
%
% Output:
% training.xml, and training_with_face_landmarks.xml files written in the
% directory

files = dir(facesdir);
faces = cell(0,1);

% all filenames with jpg are extracted to the faces cell array:
for n = 1:length(files)
    if not(isempty(strfind(files(n).name,'jpg')))
        faces{length(faces)+1} = [files(n).name];
    end
end

% setting up the training xml metadata
trainingxml = com.mathworks.xml.XMLUtils.createDocument('dataset');
training = trainingxml.getDocumentElement;
training_name_node = trainingxml.createElement('name');
training_name = trainingxml.createTextNode('Training faces');
training_comment_node = trainingxml.createElement('comment');
training_comment = trainingxml.createTextNode('These faces recognized by face++');
training_images_node = trainingxml.createElement('images');

training.appendChild(training_name_node);
training_name_node.appendChild(training_name);
training.appendChild(training_comment_node);
training_comment_node.appendChild(training_comment);
training.appendChild(training_images_node);

% setting up the training_landmarks xml metadata
landmarksxml = com.mathworks.xml.XMLUtils.createDocument('dataset');
landmarks = landmarksxml.getDocumentElement;
landmarks_name_node = landmarksxml.createElement('name');
landmarks_name = landmarksxml.createTextNode('Training faces');
landmarks.appendChild(landmarks_name_node);
landmarks_name_node.appendChild(landmarks_name);

landmarks_comment_node = landmarksxml.createElement('comment');
landmarks_comment = landmarksxml.createTextNode('found by face++');
landmarks.appendChild(landmarks_comment_node);
landmarks_comment_node.appendChild(landmarks_comment);

landmarks_images_node = landmarksxml.createElement('images');
landmarks.appendChild(landmarks_images_node);

% entering the xml data into the files
for n = 1:length(faces)
    image_node = trainingxml.createElement('image');
    image_node.setAttribute('file', faces{n});
    [Cx, Cy, w, h, Xp, Yp] = getBound(faces{n});
    training_images_node.appendChild(image_node);
    image_box = trainingxml.createElement('box');
    
    image_box.setAttribute('top', num2str(Cx));
    image_box.setAttribute('left', num2str(Cy));
    image_box.setAttribute('width', num2str(w));
    image_box.setAttribute('height', num2str(h));
    
    image_node.appendChild(image_box);
    
    
    % doing the landmarks setup
    landmarks_image_node = landmarksxml.createElement('image');
    landmarks_image_node.setAttribute('file', faces{n});
    landmarks_images_node.appendChild(landmarks_image_node);
    landmarks_image_box = landmarksxml.createElement('box');
    
    landmarks_image_box.setAttribute('top', num2str(Cx));
    landmarks_image_box.setAttribute('left', num2str(Cy));
    landmarks_image_box.setAttribute('width', num2str(w));
    landmarks_image_box.setAttribute('height', num2str(h));
    
    landmarks_image_node.appendChild(landmarks_image_box);
    
    % iterating through the points of the landmarks list
    for i = 1:83
        part_node = landmarksxml.createElement('part');
        part_node.setAttribute('name', num2str(i));
        part_node.setAttribute('x', num2str(Xp(i)));
        part_node.setAttribute('y', num2str(Yp(i)));
        landmarks_image_box.appendChild(part_node);
    end
end

% writing the files
xmlwrite('training.xml', training);
type('training.xml');

xmlwrite('training_with_face_landmarks.xml', landmarks);
type('training_with_face_landmarks.xml');

return