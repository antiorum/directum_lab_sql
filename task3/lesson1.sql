create login TEST_LOGIN with password = '1234'

use Chep_LabstudyNew
create user TEST_USER for login TEST_LOGIN

ALTER server ROLE sysadmin ADD MEMBER TEST_LOGIN ;