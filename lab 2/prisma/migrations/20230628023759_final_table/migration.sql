/*
  Warnings:

  - You are about to drop the column `student_id` on the `merit_points` table. All the data in the column will be lost.
  - You are about to drop the column `subject_id` on the `merit_points` table. All the data in the column will be lost.
  - You are about to drop the column `teacher_id` on the `merit_points` table. All the data in the column will be lost.
  - Added the required column `created_at` to the `merit_points` table without a default value. This is not possible if the table is not empty.
  - Added the required column `point` to the `merit_points` table without a default value. This is not possible if the table is not empty.
  - Added the required column `remark` to the `merit_points` table without a default value. This is not possible if the table is not empty.
  - Added the required column `studentsId` to the `merit_points` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subjectsId` to the `merit_points` table without a default value. This is not possible if the table is not empty.
  - Added the required column `teachersId` to the `merit_points` table without a default value. This is not possible if the table is not empty.
  - Added the required column `terminal` to the `merit_points` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `merit_points` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "merit_points" DROP COLUMN "student_id",
DROP COLUMN "subject_id",
DROP COLUMN "teacher_id",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "point" INTEGER NOT NULL,
ADD COLUMN     "remark" VARCHAR(50) NOT NULL,
ADD COLUMN     "studentsId" INTEGER NOT NULL,
ADD COLUMN     "subjectsId" INTEGER NOT NULL,
ADD COLUMN     "teachersId" INTEGER NOT NULL,
ADD COLUMN     "terminal" INTEGER NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AddForeignKey
ALTER TABLE "merit_points" ADD CONSTRAINT "merit_points_teachersId_fkey" FOREIGN KEY ("teachersId") REFERENCES "teachers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "merit_points" ADD CONSTRAINT "merit_points_subjectsId_fkey" FOREIGN KEY ("subjectsId") REFERENCES "subjects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "merit_points" ADD CONSTRAINT "merit_points_studentsId_fkey" FOREIGN KEY ("studentsId") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
