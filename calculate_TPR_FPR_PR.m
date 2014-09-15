function [ TPR, FPR, PR ] = calculate_TPR_FPR_PR ( STATS, TPlist, TNlist )

% this function is designed to calculate the true positive rate and the
% true negative rate as well as the precision rate beased on the number of
% detections by the tested classifier, the list of true positives and true
% negatives.

% the function was modified on 2014.09.11 to change the calculation of the
% TPR and FPR from the 'receiver operating characteristic (ROC)' to the 'free response
% receiver operating characteristic curve'.

    TP = 0;
    for i = 1:length(TPlist)
        for j = 1:length(STATS)
            if norm([STATS(j).Centroid(1)-TPlist(i).c STATS(j).Centroid(2)-TPlist(i).r]) <= 3
                TP = TP + 1;
                break;
            end
        end
    end
    TPR = TP/length(TPlist);
    
    
    % Calculate false positive rate.
    FP = 0;
    for i = 1:length(STATS)
        fpflag = 1;
        for j = 1:length(TPlist)
            if norm([STATS(i).Centroid(1)-TPlist(j).c STATS(i).Centroid(2)-TPlist(j).r]) <= 3
                fpflag = 0;
            end
        end
        if fpflag == 1
            FP = FP + 1;
        end
    end
    
%     TN = length(TNlist);
%     for i = 1:length(TNlist)
%         for j = 1:length(STATS)
%             if norm([STATS(j).Centroid(1)-TNlist(i).c STATS(j).Centroid(2)-TNlist(i).r]) < 3
%                 TN = TN - 1;
%                 break;
%             end
%         end
%     end
    
%     commented out below since it is the standard false positive rate and not the 
%     free response false positive rate that we actually want. 
%     FPR = FP/(FP+TN); 
    

%     The free response false positive rate TPR comes below.
      FPR = FP/length(TPlist);  

      PR = TP/(TP + FP);


end

