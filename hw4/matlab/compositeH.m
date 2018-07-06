function [ composite_img ] = compositeH( H2to1, template, img )
    warp_im = warpH(template, inv(H2to1), size(img),0);
    composite_img = img;
    composite_img(warp_im~=0) = warp_im(warp_im~=0);
%     imshow(composite_img);
end