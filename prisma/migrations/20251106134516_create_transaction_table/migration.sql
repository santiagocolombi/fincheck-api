/*
  Warnings:

  - The values [CHEKING] on the enum `bank_account_type` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `userId` on the `Category` table. All the data in the column will be lost.
  - Added the required column `type` to the `Category` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `Category` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "transaction_type" AS ENUM ('INCOME', 'EXPENSE');

-- AlterEnum
BEGIN;
CREATE TYPE "bank_account_type_new" AS ENUM ('CHECKING', 'INVESTMENT', 'CASH');
ALTER TABLE "bank_accounts" ALTER COLUMN "type" TYPE "bank_account_type_new" USING ("type"::text::"bank_account_type_new");
ALTER TYPE "bank_account_type" RENAME TO "bank_account_type_old";
ALTER TYPE "bank_account_type_new" RENAME TO "bank_account_type";
DROP TYPE "public"."bank_account_type_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "Category" DROP CONSTRAINT "Category_userId_fkey";

-- AlterTable
ALTER TABLE "Category" DROP COLUMN "userId",
ADD COLUMN     "type" "transaction_type" NOT NULL,
ADD COLUMN     "user_id" UUID NOT NULL;

-- CreateTable
CREATE TABLE "transactions" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "bank_account_id" UUID NOT NULL,
    "category_id" UUID,
    "name" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "type" "transaction_type" NOT NULL,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_bank_account_id_fkey" FOREIGN KEY ("bank_account_id") REFERENCES "bank_accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE SET NULL ON UPDATE CASCADE;
