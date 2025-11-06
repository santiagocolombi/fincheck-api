/*
  Warnings:

  - You are about to drop the column `serId` on the `Category` table. All the data in the column will be lost.
  - Added the required column `icon` to the `Category` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Category` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Category` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Category" DROP COLUMN "serId",
ADD COLUMN     "icon" TEXT NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL,
ADD COLUMN     "userId" UUID NOT NULL;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
