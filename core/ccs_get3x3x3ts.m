function nbrs_ts = ccs_get3x3x3ts(rfmri_vol,x,y,z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

nbrs_ts = [ squeeze(rfmri_vol(x-1,y-1,z-1,:)) squeeze(rfmri_vol(x,y-1,z-1,:)) squeeze(rfmri_vol(x+1,y-1,z-1,:)) ...
    squeeze(rfmri_vol(x-1,y,z-1,:)) squeeze(rfmri_vol(x,y,z-1,:)) squeeze(rfmri_vol(x+1,y,z-1,:)) ...
    squeeze(rfmri_vol(x-1,y+1,z-1,:)) squeeze(rfmri_vol(x,y+1,z-1,:)) squeeze(rfmri_vol(x+1,y+1,z-1,:)) ...
    squeeze(rfmri_vol(x-1,y-1,z,:)) squeeze(rfmri_vol(x,y-1,z,:)) squeeze(rfmri_vol(x+1,y-1,z,:)) ...
    squeeze(rfmri_vol(x-1,y,z,:)) squeeze(rfmri_vol(x,y,z,:)) squeeze(rfmri_vol(x+1,y,z,:)) ...
    squeeze(rfmri_vol(x-1,y+1,z,:)) squeeze(rfmri_vol(x,y+1,z,:)) squeeze(rfmri_vol(x+1,y+1,z,:)) ...
    squeeze(rfmri_vol(x-1,y-1,z+1,:)) squeeze(rfmri_vol(x,y-1,z+1,:)) squeeze(rfmri_vol(x+1,y-1,z+1,:)) ...
    squeeze(rfmri_vol(x-1,y,z+1,:)) squeeze(rfmri_vol(x,y,z+1,:)) squeeze(rfmri_vol(x+1,y,z+1,:)) ...
    squeeze(rfmri_vol(x-1,y+1,z+1,:)) squeeze(rfmri_vol(x,y+1,z+1,:)) squeeze(rfmri_vol(x+1,y+1,z+1,:)) ];
    
end

