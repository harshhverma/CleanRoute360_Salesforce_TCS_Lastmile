public class VisitLogBatchScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new VisitLogBatch(), 200);
    }
}