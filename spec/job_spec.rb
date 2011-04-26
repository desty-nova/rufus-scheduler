
#
# Specifying rufus-scheduler
#
# Wed Apr 27 00:51:07 JST 2011
#

require File.join(File.dirname(__FILE__), 'spec_base')


describe 'job classes' do

  before(:each) do
    @s = start_scheduler
  end
  after(:each) do
    stop_scheduler(@s)
  end

  #describe Rufus::Scheduler::Job do
  #  describe '#running' do
  #  end
  #end

  describe Rufus::Scheduler::AtJob do

    describe '#unschedule' do

      it 'removes the job from the scheduler' do

        job = @s.at Time.now + 3 * 3600 do
        end

        wait_next_tick

        job.unschedule

        @s.jobs.size.should == 0
      end
    end

    describe '#next_time' do

      it 'returns the time when the job will trigger' do

        t = Time.now + 3 * 3600

        job = @s.at Time.now + 3 * 3600 do
        end

        job.next_time.class.should == Time
        job.next_time.to_i.should == t.to_i
      end
    end
  end

  describe Rufus::Scheduler::InJob do

    describe '#unschedule' do

      it 'removes the job from the scheduler' do

        job = @s.in '2d' do
        end

        wait_next_tick

        job.unschedule

        @s.jobs.size.should == 0
      end
    end

    describe '#next_time' do

      it 'returns the time when the job will trigger' do

        t = Time.now + 3 * 3600

        job = @s.in '3h' do
        end

        job.next_time.class.should == Time
        job.next_time.to_i.should == t.to_i
      end
    end
  end

  describe Rufus::Scheduler::EveryJob do

    describe '#next_time' do

      it 'returns the time when the job will trigger' do

        t = Time.now + 3 * 3600

        job = @s.every '3h' do
        end

        job.next_time.class.should == Time
        job.next_time.to_i.should == t.to_i
      end
    end
  end

  describe Rufus::Scheduler::CronJob do

    describe '#next_time' do

      it 'returns the time when the job will trigger' do

        job = @s.cron '* * * * *' do
        end

        job.next_time.class.should == Time
        (job.next_time.to_i - Time.now.to_i).should satisfy { |v| v < 60 }
      end
    end
  end
end
