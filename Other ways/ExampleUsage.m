function [ ] = ExampleUsage()
h = EmotivEEG;
h.Run

for i = 1:5
    data_local = h.data;
    data_local = (data_local+1)*10;
    plot(data_local);
    pause(0.5);
end


% lastfilename = h.Record(10);
% h.LoadRecordedData(lastfilename)
% data_local = h.data;
% plot(data_local);

delete(h);
end

